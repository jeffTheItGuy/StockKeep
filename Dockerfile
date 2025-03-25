# Use the official .NET SDK image to build the app
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build

# Set the working directory inside the container
WORKDIR /app

# Copy the .csproj and restore dependencies (via dotnet restore)
COPY *.csproj ./
RUN dotnet restore

# Copy the rest of the application code
COPY . ./

# Publish the application to the /out folder in the container
RUN dotnet publish -c Release -o /out

# Use the official ASP.NET Core runtime image for the final image
FROM mcr.microsoft.com/dotnet/aspnet:8.0 AS runtime

# Set the working directory inside the container
WORKDIR /app

# Copy the published files from the build container
COPY --from=build /out .

# Set the environment variable to specify the ASP.NET Core environment (optional)
ENV ASPNETCORE_ENVIRONMENT=Production

# Expose the port that the app will run on
EXPOSE 80

# Run the application
ENTRYPOINT ["dotnet", "StockKeep.dll"]
