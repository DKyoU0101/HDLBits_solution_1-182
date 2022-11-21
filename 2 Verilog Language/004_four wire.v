module top_module( 
    input a,b,c,
    output w,x,y,z ); 
    // input, output은 따로 지정하지 않는 한 자동으로 wire 선언됨

    assign w = a;
    assign x = b;
    assign y = b;
    assign z = c;

endmodule
