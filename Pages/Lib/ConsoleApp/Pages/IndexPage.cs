using static ConsoleApp.SegmentMarker;

namespace ConsoleApp.Pages
{
    public record IndexPage : AbstractPage
    {
        static readonly SegmentMarker[] Markers = new[] { TableOfContents };

        public IndexPage(string contents) : base(contents, Markers) { }
    }
}
