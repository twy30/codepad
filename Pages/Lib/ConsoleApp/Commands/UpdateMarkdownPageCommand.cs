using ConsoleApp.Pages;
using static ConsoleApp.SegmentMarker;
using static ConsoleApp.Statics;
using System.IO;
using System.Linq;
using System.Text;

namespace ConsoleApp.Commands
{
    public class UpdateMarkdownPageCommand : AbstractCommand
    {
        public string[] PagePaths { get; }

        public UpdateMarkdownPageCommand(string[] arguments) : base(arguments)
        {
            PagePaths = arguments.Skip(1).ToArray();
            ThrowIfNotRegularFile(nameof(PagePaths), PagePaths);
        }

        public override void Execute()
        {
            foreach (var pagePath in PagePaths)
            {
                var pageContents = File.ReadAllText(pagePath);
                var markdownPage = new MarkdownPage(pageContents);
                File.WriteAllText(
                    pagePath,
                    new StringBuilder()
                        .Append(markdownPage.PageStart)
                        .Append(new HtmlPage(pageContents).SegmentContents[HtmlTitle])
                        .Append(markdownPage.SegmentEnds[MarkdownTitle])
                        .ToString()
                );
            }
        }
    }
}
