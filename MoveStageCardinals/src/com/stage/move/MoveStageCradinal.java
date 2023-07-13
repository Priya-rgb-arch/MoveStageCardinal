package com.stage.move;

import java.io.IOException;
import java.io.InputStream;
import java.io.*;

public class MoveStageCradinal {

	public static void main(String[] args) {
		try {
			String scriptPath = "/mnt/c/Users/upandeti/eclipse-workspace/Hello world/scripts/csv.sh";

			// Create the ProcessBuilder for the shell script

			ProcessBuilder processBuilder = new ProcessBuilder("bash", scriptPath);

			// Start the process

			Process process = processBuilder.start();

			// Wait for the process to complete
			int exitCode = process.waitFor();

			// Handle the exit code
			if (exitCode == 0) {
				System.out.println(
						"Cardinal cost file move to source directory and Cost changes pushed to the store database successfully.");
			} else {
				System.out.println("Failed. Exit code: " + exitCode);
			}
		} catch (IOException | InterruptedException e) {
			e.printStackTrace();
		}

	}
}
