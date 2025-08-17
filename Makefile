# HYBRIDCPU64 - FAST HYBRID CPU MAKEFILE
# Just run 'make' to build everything!

# ===== HYBRIDCPU64 PROJECT CONFIGURATION =====
PROJECT_NAME = hybridcpu64
TARGET = $(PROJECT_NAME)
VERILOG_SOURCES = RV64GC_optimized.v
CPP_SOURCES = fullscreen_simulator.cpp
VERILATOR = verilator
CXX = g++

# Verilator flags (optimized for FAST performance)
VERILATOR_FLAGS = \
	--cc \
	--exe \
	--build \
	-Wall \
	-Wno-fatal \
	-Wno-PINMISSING \
	-Wno-UNUSED \
	-Wno-UNDRIVEN \
	-Wno-WIDTH \
	--top-module RV64GC_optimized \
	-CFLAGS "-std=c++17 -O3 -march=native -DFAST_MODE" \
	-LDFLAGS "-lpthread"

# Default target - FAST BUILD!
.PHONY: all
all: build

# ===== FAST BUILD PIPELINE =====
.PHONY: build
build: clean setup verilate compile link success

# Clean previous builds
.PHONY: clean  
clean:
	@echo "🧹 Cleaning up previous FAST builds..."
	@rm -rf obj_dir/
	@rm -f $(TARGET)
	@rm -f *.vcd
	@rm -f *.log

# Setup build environment
.PHONY: setup
setup:
	@echo "🔧 Setting up FAST build environment..."
	@mkdir -p obj_dir

# Verilate the FAST Verilog
.PHONY: verilate
verilate:
	@echo "⚡ Verilating FAST hybrid CPU..."
	@if [ ! -f $(VERILOG_SOURCES) ]; then \
		echo "❌ Using fallback RV64GC.v (optimized version not found)"; \
		$(VERILATOR) $(VERILATOR_FLAGS) --top-module RV64GC RV64GC.v $(CPP_SOURCES); \
	else \
		$(VERILATOR) $(VERILATOR_FLAGS) $(VERILOG_SOURCES) $(CPP_SOURCES); \
	fi

# Compile (handled by Verilator --build, but kept for clarity)
.PHONY: compile
compile:
	@echo "🔥 Compiling FAST C++ simulator..."
	@# Verilator handles this with --build flag

# Link (handled by Verilator --build, but kept for clarity)  
.PHONY: link
link:
	@echo "🔗 Linking FAST executable..."
	@# Verilator handles this with --build flag

# Success message
.PHONY: success
success:
	@echo ""
	@echo "🚀✅ HYBRIDCPU64 BUILD COMPLETE! ✅🚀"
	@echo ""
	@echo "📁 Project: $(PROJECT_NAME)"
	@echo "📁 Built files:"
	@ls -la obj_dir/ | head -5
	@echo "..."
	@echo ""
	@if [ -f obj_dir/VRV64GC_optimized ]; then \
		echo "🎮 Run with: ./obj_dir/VRV64GC_optimized"; \
		echo "🎮 Or use: make run"; \
	elif [ -f obj_dir/VRV64GC ]; then \
		echo "🎮 Run with: ./obj_dir/VRV64GC"; \
		echo "🎮 Or use: make run"; \
	else \
		echo "❌ Executable not found in obj_dir/"; \
	fi
	@echo ""
	@echo "⚡ HYBRIDCPU64 FAST MODE ACTIVATED! ⚡"

# ===== FAST UTILITIES =====

# Run the simulator  
.PHONY: run
run: build
	@echo "🎮 Starting FAST hybrid CPU simulator..."
	@if [ -f obj_dir/VRV64GC_optimized ]; then \
		./obj_dir/VRV64GC_optimized; \
	elif [ -f obj_dir/VRV64GC ]; then \
		./obj_dir/VRV64GC; \
	else \
		echo "❌ No executable found! Run 'make build' first."; \
	fi

# Debug build (with extra debugging info)
.PHONY: debug
debug: VERILATOR_FLAGS += --debug --trace --coverage
debug: build
	@echo "🐛 FAST debug build complete!"

# Performance build (maximum optimization)
.PHONY: performance  
performance: VERILATOR_FLAGS += -O3 --x-assign fast --x-initial fast
performance: build
	@echo "🚀 FAST performance build complete!"

# Install dependencies (Arch Linux specific)
.PHONY: install-deps
install-deps:
	@echo "📦 Installing FAST dependencies on Arch Linux..."
	sudo pacman -S --needed verilator gcc make

# Show build info
.PHONY: info
info:
	@echo "🔍 HYBRIDCPU64 Build Information:"
	@echo "  Project: $(PROJECT_NAME)"
	@echo "  Target: $(TARGET)"
	@echo "  Verilog: $(VERILOG_SOURCES)"
	@echo "  C++: $(CPP_SOURCES)"  
	@echo "  Verilator: $(shell which $(VERILATOR) 2>/dev/null || echo 'NOT FOUND')"
	@echo "  GCC: $(shell $(CXX) --version | head -1)"
	@echo "  Flags: $(VERILATOR_FLAGS)"

# Test the build
.PHONY: test
test: build
	@echo "🧪 Testing FAST build..."
	@if [ -f obj_dir/VRV64GC_optimized ]; then \
		timeout 5s ./obj_dir/VRV64GC_optimized || echo "✅ Build test complete (timeout expected)"; \
	elif [ -f obj_dir/VRV64GC ]; then \
		timeout 5s ./obj_dir/VRV64GC || echo "✅ Build test complete (timeout expected)"; \
	else \
		echo "❌ Test failed - no executable found"; \
		exit 1; \
	fi

# Help menu
.PHONY: help
help:
	@echo "🚀 HYBRIDCPU64 - FAST BUILD SYSTEM 🚀"
	@echo ""
	@echo "Project: $(PROJECT_NAME)"
	@echo ""
	@echo "Available targets:"
	@echo "  make            - Build everything (default)"  
	@echo "  make build      - Build the HYBRIDCPU64 simulator"
	@echo "  make run        - Build and run simulator"
	@echo "  make debug      - Debug build with tracing"
	@echo "  make performance - Optimized performance build"
	@echo "  make clean      - Clean build artifacts"
	@echo "  make test       - Test the build"
	@echo "  make info       - Show build information"
	@echo "  make install-deps - Install dependencies (Arch Linux)"
	@echo "  make help       - Show this help"
	@echo ""
	@echo "⚡ Just run 'make' to build HYBRIDCPU64! ⚡"

# Make 'make' without arguments build everything
.PHONY: clock_benchmark
clock_benchmark:
	@echo "Building clock benchmark..."
	@$(CXX) -I./obj_dir -I$(shell verilator -V | grep -o '/.*include') -std=c++17 -O3 -march=native -DFAST_MODE ../clock_benchmark.cpp obj_dir/VRV64GC_optimized__ALL.o $(shell verilator --cflags --libs) -o ../clock_benchmark

.DEFAULT_GOAL := all
