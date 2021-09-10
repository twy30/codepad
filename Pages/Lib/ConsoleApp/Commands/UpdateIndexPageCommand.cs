using ConsoleApp.Pages;
using static ConsoleApp.SegmentMarker;
using static ConsoleApp.Statics;
using System;
using System.IO;
using System.Linq;
using System.Text;

namespace ConsoleApp.Commands
{
    public class UpdateIndexPageCommand : AbstractCommand
    {
        public string IndexPagePath { get; }
        public string[] PagePaths { get; }

        public UpdateIndexPageCommand(string[] arguments) : base(arguments)
        {
            IndexPagePath = arguments.GetArgument(1);
            ThrowIfNotRegularFile(nameof(IndexPagePath), IndexPagePath);
            PagePaths = arguments.Skip(2).ToArray();
            ThrowIfNotRegularFile(nameof(PagePaths), PagePaths);
        }

        public override void Execute()
        {
            var indexPageBuilder = new StringBuilder();
            var indexPage = new IndexPage(File.ReadAllText(IndexPagePath));
            indexPageBuilder.Append(indexPage.PageStart);
            string indexParentFolderPath = Path.GetDirectoryName(IndexPagePath) + Path.DirectorySeparatorChar;
            foreach (var pagePath in PagePaths.OrderBy(_ => _))
            {
                var page = new HtmlPage(File.ReadAllText(pagePath));
                var pageTitle = page.SegmentContents[HtmlTitle];
                var pageLink = pagePath;
                if (pageLink.StartsWith(indexParentFolderPath, StringComparison.Ordinal))
                {
                    pageLink = Path.DirectorySeparatorChar + pageLink.Substring(indexParentFolderPath.Length);
                }
                indexPageBuilder
                    .Append("* [")
                    .Append(pageTitle)
                    .Append("](")
                    .Append(pageLink)
                    .AppendLine(")");
            }
            indexPageBuilder.Append(indexPage.SegmentEnds[TableOfContents]);
            File.WriteAllText(IndexPagePath, indexPageBuilder.ToString());
        }
    }
}
