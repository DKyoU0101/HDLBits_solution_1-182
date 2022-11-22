# "{숫자}_{파일형식}" 파일명 다수 생성
import os

def create_File(path, format, start, end):
    
    for i in range(start, end+1):
        filename = str(i).zfill(3) + "_" + format
        path_name = os.path.join(path, f'{str(i).zfill(3)}_{format}')
        f = open(path_name, 'w')
        f.close
    
    
    

if __name__ == '__main__':
    
    #사용자설정
    ####################################################
    save_path = r"C:\verilog_study\HDLBits"
    save_format = ".v"
    
    start_num = 1
    end_num = 200
    ####################################################
    
    create_File(save_path, save_format, start_num, end_num)
