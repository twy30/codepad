using static ConsoleApp.SegmentMarker;

namespace ConsoleApp.Pages
{
    public record HtmlPage : AbstractPage
    {
        public static readonly SegmentMarker[] Markers = new[] {
            HtmlLang,
            HtmlTitle,
            MarkdownInput,
        };

        public HtmlPage(string contents) : base(contents, Markers) { }
    }
}
