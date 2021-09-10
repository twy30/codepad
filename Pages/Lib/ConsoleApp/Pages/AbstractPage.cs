using static ConsoleApp.Statics;
using System.Collections.Generic;

namespace ConsoleApp.Pages
{
    public abstract record AbstractPage
    {
        public string PageStart { get; }
        public IDictionary<SegmentMarker, string> SegmentContents { get; }
        public IDictionary<SegmentMarker, string> SegmentEnds { get; }

        public AbstractPage(string contents, SegmentMarker[] markers)
        {
            (PageStart, SegmentContents, SegmentEnds) = ParsePage(contents, markers);
        }
    }
}
