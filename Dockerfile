# Use official JDK image
FROM openjdk:17-alpine

# Set working directory
WORKDIR /app

# Copy Java source code
COPY AASCIISum.java .

# Compile Java code
RUN javac AASCIISum.java

# Run program
CMD ["java", "AASCIISum"]
