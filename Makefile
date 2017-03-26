TARGET := x86emu

SRCS := main.cpp debug.cpp
OBJS := $(SRCS:.cpp=.o)
DEPS := $(SRCS:.cpp=.d)

SUB_OBJS := hardware/hardware.a
SUB_OBJS += emulator/emulator.a
SUB_OBJS += instruction/instruction.a
SUB_OBJS += device/device.a

CXXFLAGS := -Wall -MMD -I./include

$(TARGET): $(OBJS) $(SUB_OBJS)
	$(CXX) $(CXXFLAGS) $^ -o $@

-include $(DEPS)

$(SUB_OBJS):
	make -C hardware
	make -C emulator
	make -C instruction
	make -C device

all:
	make -C hardware
	make -C emulator
	make -C instruction
	make -C device
	make $(TARGET)

clean:
	make clean -C hardware
	make clean -C emulator
	make clean -C instruction
	make clean -C device
	$(RM) $(DEPS) $(OBJS) $(TARGET)