using ConsoleApp.Commands;
using System;
using System.Text.RegularExpressions;
using Xunit;

namespace Tests.Commands
{
    public class NewSegmentMarkerCommandTests
    {
        [Theory]
        [InlineData("<!--")]
        [InlineData("-->")]
        [InlineData("--!>")]
        public void Constructor_InvalidName(string name)
        {
            Assert.Throws<ArgumentOutOfRangeException>(
                "SegmentName",
                () => new NewSegmentMarkerCommand(new[] { string.Empty, name })
            );
        }

        [Fact]
        public void GetSegmentMarker()
        {
            var name = Guid.NewGuid().ToString();
            Assert.Matches(
                Regex.Escape("<!-- " + name + " ") + "[!-~]{41}" + Regex.Escape(" -->"),
                NewSegmentMarkerCommand.GetSegmentMarker(name)
            );
        }
    }
}
