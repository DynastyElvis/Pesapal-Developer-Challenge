//  Here is a simple implementation of the machine simulator in Java:

import java.util.Scanner;

public class Simulator {
    private static final int HALT = 0x00;
    private static final int NOP = 0x01;
    private static final int LI = 0x02;
    private static final int LW = 0x03;
    private static final int SW = 0x04;
    private static final int ADD = 0x05;
    private static final int SUB = 0x06;
    private static final int MULT = 0x07;
    private static final int DIV = 0x08;
    private static final int J = 0x09;
    private static final int JR = 0x0A;
    private static final int BEQ = 0x0B;
    private static final int BNE = 0x0C;
    private static final int INC = 0x0D;
    private static final int DEC = 0x0E;

    private static int[] memory = new int[0x10000];
    private static int[] register = new int[5];

    public static void main(String[] args) {
        Scanner scan = new Scanner(System.in);
        int pc = 0xCFFF;
        System.out.println("Enter the program: ");
        String input = scan.nextLine();
        String[] program = input.split(" ");
        for (String line : program) {
            int instruction = getInstruction(line);
            int[] parameters = getParameters(line, instruction);
            switch (instruction) {
                case HALT:
                    System.out.println("Program Halted.");
                    System.out.println("Final Register Values: ");
                    for (int i = 0; i < 5; i++) {
                        System.out.println("R" + (i + 1) + ": " + register[i]);
                    }
                    return;
                case NOP:
                    break;
                case LI:
                    register[parameters[0]] = parameters[1];
                    break;
                case LW:
                    register[parameters[0]] = memory[register[parameters[1]]];
                    break;
                case SW:
                    memory[register[parameters[0]]] = register[parameters[1]];
                    break;
                case ADD:
                    register[parameters[2]] = register[parameters[0]] + register[parameters[1]];
                    break;
                case SUB:
                    register[parameters[2]] = register[parameters[0]] - register[parameters[1]];
                    break;
                case MULT:
                    register[parameters[2]] = register[parameters[0]] * register[parameters[1]];
                    break;
                case DIV:
                    register[parameters[2]] = register[parameters[0]] / register[parameters[1]];
                    break;
                case J:
                    pc = parameters[0];
                    break;
                case JR:
                    pc = register[parameters[0]];
                    break;
                case BEQ:
                    if (register[parameters[0]] == register[parameters[1]]) {
                        pc = register[parameters[2]];
                    }
                    break;
                case

