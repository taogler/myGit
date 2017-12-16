################################## 指定编译器 ###################################

# C
CC := gcc

# C++
CXX := g++

# Fortran 77
F77 := ifort

# Fortran 90
FC := gfortran

# ld wrapper
LD := ${CXX}
################################## 指定编译参数 #################################

# 预处理器参数(C/C++, Fortran)
CPPFLAGS := -cpp

# C
CFLAGS :=

# C++
CXXFLAGS :=

# Fortran 77 (fixed form)
FFLAGS :=

# Fortran 90 (free form)
FCFLAGS :=

# 链接器参数(C/C++, Fortran)
LDFLAGS := -Wl,--no-undefined
################################## 其它参数设置 #################################

# 头文件搜索路径
INCS :=

# 库文件搜索路径
LIBS :=

# 链接的库名(不包括前缀lib以及后缀.a/.so)
LNKS :=

# 源文件列表
SRCS := $(sort $(wildcard *.c *.cpp *.for *.f90))

# 对INCS, LIBS, LNKS分别添加-I, -L, -l前缀
INCS := $(addprefix -I, ${INCS})
LIBS := $(addprefix -L, ${LIBS})
LNKS := $(addprefix -l, ${LNKS})

# 追加链接器参数
RPATH   := -Wl,-rpath=
LDFLAGS += $(subst -L, ${RPATH}, ${LIBS})

# 目标文件列表
OBJS := $(shell echo ${SRCS} | sed 's/\.[^[:space:]]\+/.o/g')

# 链接目标
BIN := $(shell basename $(shell pwd))
################################## make执行相关 #################################

# 伪目标
.PHONY: run clean

${BIN}: ${OBJS}
	${LD} ${LDFLAGS} -o $@ $^ ${LIBS} ${LNKS}

run:
	./${BIN}

clean:
	-rm ${BIN}
	-rm *.o

# 模式规则
%.o: %.c
	${CC}  ${CPPFLAGS} ${CFLAGS}   -c $< ${INCS}

%.o: %.cpp
	${CXX} ${CPPFLAGS} ${CXXFLAGS} -c $< ${INCS}

%.o: %.for
	${F77} ${CPPFLAGS} ${FFLAGS}   -c $< ${INCS}

%.o: %.f90
	${FC}  ${CPPFLAGS} ${FCFLAGS}  -c $< ${INCS}
