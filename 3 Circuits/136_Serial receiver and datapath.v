module top_module(
    input clk,
    input in,
    input reset,    // Synchronous reset
    output [7:0] out_byte,
    output done
); //

    // Use FSM from Fsm_serial
    reg [8:1] count, data;
    reg ready, start_data, end_data;
    wire [8:1] n_count, n_data;
    wire n_ready, n_start, n_done;

    always @(*) begin
        n_start = in & (start_data | ready | done);
        begin
            n_count[1] = (~in) & (start_data | done);
            n_count[8:2] = count[7:1];
        end
        n_ready = (~in) & (end_data | ready);
        n_done = (in & end_data);
        if(|count) begin
            case (count)
                8'b0000_0001: n_data[1] = in;
                8'b0000_0010: n_data[2] = in;
                8'b0000_0100: n_data[3] = in;
                8'b0000_1000: n_data[4] = in;
                8'b0001_0000: n_data[5] = in;
                8'b0010_0000: n_data[6] = in;
                8'b0100_0000: n_data[7] = in;
                8'b1000_0000: n_data[8] = in;
            endcase
        end
        else n_data = data;
    end

    always @(posedge clk) begin
        if(reset) begin
            start_data <= 1;
            count <= 0;
            end_data <= 0;
            ready <= 0;
            done <= 0;
            data <= 0;
        end 
        else begin
            start_data <= n_start;
            count <= n_count;
            end_data <= count[8];
            ready <= n_ready;
            done <= n_done;
            data <= n_data;
        end
    end

    assign out_byte = (done) ? data : 0;

endmodule
