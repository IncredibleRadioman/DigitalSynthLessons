//  блок вычисления сигналов переноса
module  carry_lookahead_generator #(
    parameter WIDTH = 8
) (
    //  входной сигнал переноса
    input   carry_in; 
    //  входная шина gi = xi and yi = 1 если при сложении xi yi 
    //  возникает перенос
    input   [WIDTH - 1 : 0] generate_in, 
    //  входная шина pi = xi xor yi = 1, если значение переноса
    //  передается от пред разряда к следующему
    input   [WIDTH -1 : 0] propagate_in,

    //  это массив переносов - в каких разрядах есть перенос
    output  [WIDTH : 0] carry,
    //  =1 - блок говорит : я гарантированно создаю перенос на выходе
    output  group_generate,
    //  =1 - блок говорит : я гарантированно распространяю перенос 
    output  group_propagate

    //  групповые сигналы нужны, так как сумматор делается из блоков
    //  например по 4 бита, где считаются групповые сигналы и вычисляется
    //  сумма (она по классике - да, долго и последовательно, но только
    //  4 бита)

    //  как только будет готов carry[3], то блок второго уровня
    //  создаст carry_in для данного блока
);

//  вводим временные массивы для хранения gi и pi

//  это массивы аккумуляторы, для того чтобы выяснить
//  порождает ли блок перенос 
wire    [WIDTH - 1 : 0] g_temp;
wire    [WIDTH - 1 : 0] p_temp;

//  нулевой элемент шины переноса соответствует входу
assign carry[0] = carry_in;

generate
    genvar i;
    for (i = 0; i <= WIDTH - 1; i = i + 1) begin : stage
        // ci+1 = ci and (gi or pi) - сигнал переноса в следующем разряде

        //  в следующем разряде будет перенос, если (в предыдущем он был 
        //  И текущий разряд его распространяет) ИЛИ
        //  текущий разряд порождает перенос
        assign carry[i+1] = generate_in[i] | propagate_in[i] & carry[i];
        case (i)
        //  для последнего элемента - сам факт возникновения важен
        //  так как это старший бит - никуда проходить не нужно (через
        //  другие биты)
        WIDTH - 1 : assign g_temp[i] = generate_in[i];
        default : begin
            //  выясняем, распр-ся ли перенос от i-го разряда на выход
            assign p_temp[i] = &propagate_in[WIDTH - 1 : i + 1];
            //  происходит ли генерация переноса от i-го разряда
            //  она будет, если в текущем разряде (i) он генерируется
            //  И этот сгенерированный перенос пролетает на выход
            assign g_temp[i] = p_temp[i] & generate_in[i];

            //  ИТОГО : родился ли перенос в i-м разряде и распр-ся ли он
            //  до выхода
        end

        //  для 4 бит
        //  i = 0 : p_temp[0] = &propagate_in[3:1] ; g_temp[0] = p_temp[0] & generate_in[0]
        //  то есть 

        endcase
    end
endgenerate

//  во всех разрядах есть распространение переноса - блок распр-т перенос
assign group_propagate = &propagate_in;
//  если хотя бы в одном разряде перенос родился и распр-ся до выхода
//  блок генерирует перенос
assign group_generate = |g_temp;

endmodule

//  вот это непосредственно сумматор 
//  который обычно делается на 4 бита (сумматор-блочок)
//  из таких блочков собирается один большой сумматор на 32 бита (например)
//  его нужно подключить к CLA второго уровня, который по групповым сигналам генерации
//  и переноса (которые здесь в воздухе) сгенерит carry_in для каждого
//  такого блочка (сумма пересчитается махом, это же комб логика)

//  а carry_out используется только в старшем сумматоре-блочке
//  сообщает о переполнении

//  carry_in для сумматора битов {7:4} (все еще пример 4-битного)
//  будет C4 = carry_in & P{3:0} | G{3:0}
//  для битов {11:8}
//  C8 = (carry_in & P{7:4} & P{3:0}) | (G{3:0} & P{7:4}) | G{7:4}
//  и т.д.
module  carry_lookahead_adder #(
    parameter WIDTH = 8
) (
    input   carry_in,
    input   [WIDTH - 1 : 0] x,
    input   [WIDTH - 1 : 0] y,
    output  [WIDTH - 1 : 0] z,
    output  carry_out
);

//  массив - есть ли перенос в i-м разряде
wire    [WIDTH : 0] carry;
//  те самые gi и pi
wire    [WIDTH - 1 : 0] generate_wire;
wire    [WIDTH - 1 : 0] propagate_wire;

//  экземпляр генератора переноса
carry_lookahead_generator #
    (.WIDTH(WIDTH))
    i_CLG (
        .carry_in(carry_in),
        .generate_in(generate_wire),
        .propagate_in(propagate_wire),
        .carry(carry),
        .group_propagate(),
        .group_generate()
    );

//  непосредственно создание сигналов pi и gi
//  а также вычисление суммы для каждого бита
generate
    genvar i;
    for (i = 0; i <= WIDTH - 1; i = i + 1) begin : stage
        assign generate_wire[i] = x[i] & y[i];
        assign propagate_wire[i] = x[i] ^ y[i];
    end
endgenerate

//  ну и выдаем на выход старший carry 
assign carry_out = carry[WIDTH];

endmodule