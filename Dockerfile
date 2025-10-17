# Step 1: Use an official JDK image to compile and run Java code
FROM openjdk:17-alpine

# Step 2: Set working directory inside container
WORKDIR /app

# Step 3: Copy your Java source code into container
COPY AASCIISum.java .

# Step 4: Compile the Java program
RUN javac AASCIISum.java

# Step 5: Run the program when the container starts

CMD ["java", "AASCIISum"]
