#################################### 指定编译器 #####################################
# C
CC = gcc

# C++
CXX = g++

# Fortran 77
F77 = ifort

# Fortran 90
FC = gfortran

# ld wrapper
LD = $(FC)
#################################### 指定编译参数 ####################################

# 预处理器参数(C/C++)
CPPFLAGS =

# C
CFLAGS =

# C++
CXXFLAGS =

# Fortran 77
FFLAGS =

# Fortran 90
FCFLAGS =

# 链接器参数(C, C++, Fortran)
LDFLAGS = #-fopenmp
#################################### 其它参数设置 ####################################

# 头文件搜索路径
INCS =  /home/spring/workinstall/MUMPS_4.10.0.gfort/libseq/ \
        /home/spring/yoo/MUMPS_4.10.0/include/ \
        /home/spring/yoo/lapack-3.7.1/LAPACKE/include/ \

# 库文件搜索路径
LIBS = /usr/local/MATLAB/R2015b/bin/glnxa64/ \
       /usr/local/MATLAB/R2015b/sys/os/glnxa64/ \
	   /home/spring/ll/Adaptive-lf/fsls20111218/lib/ \
	   /home/spring/yoo/MUMPS_4.10.0/lib/ \
	   /home/spring/yoo/MUMPS_4.10.0/libseq/ \


# 链接的库名(不包括前缀lib以及后缀.a/.so)
LNKS = lapack fftw3 dmumps blas mumps_common mpiseq pthread blas eng mx \
       mex mat pord lapacke FSLS

# 源文件列表
SRCS = $(wildcard *.c *.cpp *.for *.f90 *.F)

# 对INCS, LIBS, LNKS分别添加-I, -L, -l前缀
INCS := $(addprefix -I, $(INCS))
LIBS := $(addprefix -L, $(LIBS))
LNKS := $(addprefix -l, $(LNKS))

# 目标文件列表
OBJS = $(shell echo $(SRCS) | sed 's/\.[^[:space:]]\+/.o /g')

# 链接目标
BIN = main #$(shell basename $(shell pwd))
################################### make执行相关 ###################################

# 伪目标
.PHONY: run clean

$(BIN): $(OBJS)
	$(LD) -o $@ $^ $(LIBS) $(LNKS) $(LDFLAGS)

run:
	./$(BIN)

clean:
	-rm $(BIN)
	-rm *.o

# 模式规则
%.o: %.c
	$(CC)  $(CFLAGS)   -c $< $(INCS)

%.o: %.cpp
	$(CXX) $(CXXFLAGS) -c $< $(INCS)

%.o: %.for
	$(F77) $(FFLAGS)   -c $< $(INCS)

%.o: %.f90
	$(FC)  $(FCFLAGS)  -c $< $(INCS) 

%.o: %.F
	mex -c $<

