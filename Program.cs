var builder = WebApplication.CreateBuilder(args);

// Add services to the container.
builder.Services.AddControllersWithViews();

// Configure Kestrel to listen on all interfaces
builder.WebHost.UseKestrel(serverOptions =>
{
    serverOptions.ListenAnyIP(80); // Listen on port 80 on all interfaces
});

var app = builder.Build();

// Remove HTTPS redirection for Docker
// app.UseHttpsRedirection(); // Comment this out or remove

// Configure the HTTP request pipeline.
if (!app.Environment.IsDevelopment())
{
    app.UseExceptionHandler("/Home/Error");
    app.UseHsts();
}

app.UseStaticFiles();
app.UseRouting();
app.UseAuthorization();

app.MapControllerRoute(
    name: "default",
    pattern: "{controller=Home}/{action=Index}/{id?}");

app.Run();