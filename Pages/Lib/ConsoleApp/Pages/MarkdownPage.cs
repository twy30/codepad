using static ConsoleApp.SegmentMarker;

namespace ConsoleApp.Pages
{
    public record MarkdownPage : AbstractPage
    {
        static readonly SegmentMarker[] Markers = new[] { MarkdownTitle };

        public MarkdownPage(string contents) : base(contents, Markers) { }
    }
}
