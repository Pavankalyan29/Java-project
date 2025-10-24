# Use official JDK image
FROM openjdk:17-alpine

# Set working directory
WORKDIR /app

# Copy Java source code
COPY asciiSum.java .

# Compile Java code
RUN javac asciiSum.java

# Run program
CMD ["java", "asciiSum"]
