using ConsoleApp.Pages;
using static ConsoleApp.Statics;
using System.IO;
using System.Linq;
using System.Text;

namespace ConsoleApp.Commands
{
    public class ApplyPageTemplateCommand : AbstractCommand
    {
        public string TemplatePath { get; }
        public string[] PagePaths { get; }

        public ApplyPageTemplateCommand(string[] arguments) : base(arguments)
        {
            TemplatePath = arguments.GetArgument(1);
            ThrowIfNotRegularFile(nameof(TemplatePath), TemplatePath);
            PagePaths = arguments.Skip(2).ToArray();
            ThrowIfNotRegularFile(nameof(PagePaths), PagePaths);
        }

        public override void Execute()
        {
            var template = new HtmlPage(File.ReadAllText(TemplatePath));
            foreach (var pagePath in PagePaths)
            {
                var pageBuilder = new StringBuilder();
                pageBuilder.Append(template.PageStart);
                var page = new HtmlPage(File.ReadAllText(pagePath));
                foreach (var marker in HtmlPage.Markers)
                {
                    pageBuilder
                        .Append(page.SegmentContents[marker])
                        .Append(template.SegmentEnds[marker]);
                }
                File.WriteAllText(pagePath, pageBuilder.ToString());
            }
        }
    }
}
