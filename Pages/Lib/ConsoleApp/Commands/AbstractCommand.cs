namespace ConsoleApp.Commands
{
    public abstract class AbstractCommand
    {
        public string[] Arguments { get; }

        public AbstractCommand(string[] arguments)
        {
            Arguments = arguments;
        }

        public abstract void Execute();
    }
}
