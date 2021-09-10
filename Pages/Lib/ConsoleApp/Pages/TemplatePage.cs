using static ConsoleApp.SegmentMarker;

namespace ConsoleApp.Pages
{
    public record TemplatePage : AbstractPage
    {
        public static readonly SegmentMarker[] Markers = new[] {
            HtmlLang,
            HtmlTitle,
            MarkdownInput,
            Footer
        };

        public TemplatePage(string contents) : base(contents, Markers) { }
    }
}
