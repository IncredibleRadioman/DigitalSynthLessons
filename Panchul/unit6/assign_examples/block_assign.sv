//  исследование блокирующего присваивания
`timescale 1ns / 1ps

module      blocking_assign;

reg         op1;
reg         op2;
reg         [7:0] inc_cmd;
reg         [1:0] rev_cmd;
real        acl;
integer     cnt;

initial begin
    $display("====== Let's start %m module =====\n");
    $monitor("@%0t ns\t op1=1'b%b\t op2=1'b%b\t inc_cmd=0x%h\t rev_cmd=0x%h\t acl = %f\t cnt=%0d\n",
        $time, op1, op2, inc_cmd, rev_cmd, acl, cnt);
end

initial begin
    //  в нулевой момент времени
    op1 = 1'b1;
    op2 = 1'b0;
    cnt = 0;
    inc_cmd = 8'hFF;
    rev_cmd = inc_cmd;
    acl = 2.28;
    //  в момент времени 10 изм-ся значение inc_cmd
    inc_cmd[3:0] = #10 4'b1001;
    //  через 11 единиц времени - rev_cmd (старшего бита)
    rev_cmd[1] = #11 1'b0;
    //  через 12 единиц меняются acl, cnt, op1, op2
    acl = #12 1.2;
    cnt = cnt + 3;
    op1 = 1'b0;
    op2 = 1'b1;
end

endmodule