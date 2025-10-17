
# Use official OpenJDK image
FROM openjdk:17-alpine

# Set working directory inside container
WORKDIR /app

# Copy Java source code
COPY AASCIISum.java .

# Compile Java program
RUN javac AASCIISum.java

# Run the program
CMD ["java", "AASCIISum"]
