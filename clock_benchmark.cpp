#include "VRV64GC_optimized.h"
#include "verilated.h"
#include <iostream>
#include <chrono>
#include <iomanip>

int main(int argc, char **argv) {
    Verilated::commandArgs(argc, argv);
    VRV64GC_optimized* cpu = new VRV64GC_optimized;
    
    // Reset CPU
    cpu->rst = 1;
    cpu->clk = 0;
    cpu->eval();
    cpu->clk = 1;
    cpu->eval();
    cpu->rst = 0;
    
    std::cout << "🚀 FAST BOY HYBRID CPU - CLOCK BENCHMARK 🚀\n";
    std::cout << "============================================\n\n";
    
    const int benchmark_cycles = 1000000; // 1 million cycles
    
    auto start_time = std::chrono::high_resolution_clock::now();
    
    // Run benchmark cycles
    for (int cycle = 0; cycle < benchmark_cycles; cycle++) {
        // Positive edge
        cpu->clk = 1;
        cpu->eval();
        
        // Negative edge  
        cpu->clk = 0;
        cpu->eval();
    }
    
    auto end_time = std::chrono::high_resolution_clock::now();
    auto duration = std::chrono::duration_cast<std::chrono::microseconds>(end_time - start_time);
    
    double elapsed_seconds = duration.count() / 1000000.0;
    double cycles_per_second = benchmark_cycles / elapsed_seconds;
    double mhz = cycles_per_second / 1000000.0;
    
    std::cout << "📊 BENCHMARK RESULTS:\n";
    std::cout << "━━━━━━━━━━━━━━━━━━━━━\n";
    std::cout << "Total Cycles:        " << std::setw(12) << benchmark_cycles << "\n";
    std::cout << "Elapsed Time:        " << std::setw(12) << std::fixed << std::setprecision(6) << elapsed_seconds << " seconds\n";
    std::cout << "Cycles/Second:       " << std::setw(12) << std::fixed << std::setprecision(0) << cycles_per_second << "\n";
    std::cout << "Simulated Clock:     " << std::setw(12) << std::fixed << std::setprecision(3) << mhz << " MHz\n";
    std::cout << "\n";
    
    // Performance rating
    if (mhz > 50) {
        std::cout << "🔥 PERFORMANCE: BLAZING FAST! 🔥\n";
    } else if (mhz > 10) {
        std::cout << "⚡ PERFORMANCE: VERY FAST! ⚡\n";
    } else if (mhz > 1) {
        std::cout << "🚀 PERFORMANCE: FAST! 🚀\n";
    } else {
        std::cout << "🐌 PERFORMANCE: OPTIMIZABLE\n";
    }
    
    std::cout << "\n🎯 CPU STATE AFTER BENCHMARK:\n";
    std::cout << "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\n";
    std::cout << "PC:           0x" << std::hex << std::setw(16) << std::setfill('0') << cpu->pc << std::dec << "\n";
    std::cout << "Register Out: 0x" << std::hex << std::setw(16) << std::setfill('0') << cpu->reg_out << std::dec << "\n";
    std::cout << "Debug Instr:  0x" << std::hex << std::setw(8) << std::setfill('0') << cpu->debug_instr << std::dec << "\n";
    
    delete cpu;
    return 0;
}
