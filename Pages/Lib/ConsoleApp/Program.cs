using static ConsoleApp.Statics;

namespace ConsoleApp
{
    class Program
    {
        static void Main(string[] arguments)
        {
            var commandName = arguments.GetArgument(0);
            var command = GetCommand(commandName, arguments);
            command.Execute();
        }
    }
}
