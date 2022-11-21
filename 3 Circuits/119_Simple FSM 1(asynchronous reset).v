module top_module(
    input clk,
    input areset,    // Asynchronous reset to state B
    input in,
    output out);//  

    parameter A=0, B=1; 
    reg state, next_state;

    // always @(*) begin    // This is a combinational always block
    //     // State transition logic
    // end

    always @(posedge clk, posedge areset) begin    // This is a sequential always block
        if(areset) state <= B; // State flip-flops with asynchronous reset
        else if(state == B) state <= (in) ? B : A;
        else state <= (in) ? A : B;
    end

    // Output logic
    assign out = (state == B) ? 1 : 0;// assign out = (state == ...);

endmodule


// // solution
// module top_module(
//     input clk,
//     input areset,    // Asynchronous reset to state B
//     input in,
//     output out);//  

//     parameter A=0, B=1; 
//     reg state, next_state;

//     always @(*) begin    // This is a combinational always block
//         case (state)
//             A: next_state = in ? A : B;
//             B: next_state = in ? B : A;
//         endcase// State transition logic
//     end

//     always @(posedge clk, posedge areset) begin    // This is a sequential always block
//         if(areset) state <= B; // State flip-flops with asynchronous reset
//         else state <= next_state;
//     end

//     // Output logic
//     assign out = (state == B);// assign out = (state == ...);

// endmodule