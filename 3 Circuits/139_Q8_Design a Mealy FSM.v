module top_module (
    input clk,
    input aresetn,    // Asynchronous active-low reset
    input x,
    output z ); 

    reg [2:0] sequence_stt;
    reg [2:0] n_sequence;

    always @(*) begin
        begin
            n_sequence[0] = (~x) & (sequence_stt[0] | sequence_stt[2]);
            n_sequence[1] = (x);
            n_sequence[2] = (~x) & sequence_stt[1];
        end
    end

    always @(posedge clk, negedge aresetn) begin
        if(~aresetn) sequence_stt <= 3'b001;
        else sequence_stt <= n_sequence;
    end

    assign z = (x) & sequence_stt[2];

endmodule
