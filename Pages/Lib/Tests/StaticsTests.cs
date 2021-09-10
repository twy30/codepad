using ConsoleApp;
using ConsoleApp.Commands;
using System;
using Xunit;

namespace Tests
{
    public class StaticsTests
    {
        [Theory]
        [InlineData(-1)]
        [InlineData(0)]
        public void GetArgument_InvalidIndex(int index)
        {
            Assert.Throws<ArgumentOutOfRangeException>(
                "index",
                () => Array.Empty<string>().GetArgument(index)
            );
        }

        [Fact]
        public void GetArgument()
        {
            var argument = Guid.NewGuid().ToString();
            Assert.Equal(
                argument,
                new[] { argument }.GetArgument(0)
            );
        }

        [Fact]
        public void ThrowIfNotRegularFile_NonexistentFile()
        {
            var name = Guid.NewGuid().ToString();
            Assert.Throws<ArgumentOutOfRangeException>(
                name,
                () => Statics.ThrowIfNotRegularFile(name, string.Empty)
            );
        }

        [Fact]
        public void GetCommand_InvalidName()
        {
            Assert.Throws<ArgumentOutOfRangeException>(
                "name",
                () => Statics.GetCommand(string.Empty, Array.Empty<string>())
            );
        }

        [Fact]
        public void GetCommand()
        {
            var arguments = new[] { Guid.NewGuid().ToString() };
            var command = Statics.GetCommand("_tEST", arguments);
            Assert.Equal(typeof(_TestCommand), command.GetType());
            Assert.Equal(arguments, command.Arguments);
        }

        [Fact]
        public void ParsePage()
        {
            var pageStart = Guid.NewGuid().ToString();
            var marker = new SegmentMarker(Guid.NewGuid().ToString(), Guid.NewGuid().ToString());
            var contents = Guid.NewGuid().ToString();
            var pageEnd = Guid.NewGuid().ToString();
            var page = Statics.ParsePage(
                pageStart + marker.Start + contents + marker.End + pageEnd,
                marker
            );
            Assert.Equal(
                pageStart + marker.Start,
                page.pageStart
            );
            Assert.Equal(contents, page.segmentContents[marker]);
            Assert.Equal(
                marker.End + pageEnd,
                page.segmentEnds[marker]
            );
        }
    }
}
