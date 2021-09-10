using System;
using System.Text;

namespace ConsoleApp.Commands
{
    public class NewSegmentMarkerCommand : AbstractCommand
    {
        // https://www.w3.org/TR/2021/SPSD-html52-20210128/syntax.html#comments
        static readonly string[] illegalHtmlCommentStrings = new[] { "<!--", "-->", "--!>" };

        static int ContainsIllegalHtmlCommentString(string @string)
        {
            for (var i = 0; i < illegalHtmlCommentStrings.Length; ++i)
            {
                if (@string.Contains(illegalHtmlCommentStrings[i], StringComparison.Ordinal))
                {
                    return i;
                }
            }
            return -1;
        }

        public static string GetSegmentMarker(string name)
        {
            // 94 printable ASCII characters from `U+0021` (exclamation
            // mark `!`) to `U+007E` (tilde `~`).
            const string idCharacters = "!\"#$%&'()*+,-./0123456789:;<=>?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\\]^_`abcdefghijklmnopqrstuvwxyz{|}~";

            // const double EddingtonNumber = 1e80; // https://en.wikipedia.org/wiki/Eddington_number
            // var idLength = (int)Math.Ceiling(Math.Log(EddingtonNumber, idCharacters.Length));
            const int idLength = 41;

            var random = new Random();
            var idBuilder = new StringBuilder(idLength);
            var segmentId = string.Empty;
            do
            {
                while (idBuilder.Length < idLength)
                {
                    idBuilder.Append(idCharacters[random.Next(idCharacters.Length)]);
                }
                segmentId = idBuilder.ToString();
                if (ContainsIllegalHtmlCommentString(segmentId) < 0)
                {
                    break;
                }
                idBuilder.Clear();
            } while (true);

            const string segmentMarkerStart = "<!--";
            const string segmentMarkerEnd = "-->";
            const string segmentMarkerSeparator = " ";
            return new StringBuilder(
                segmentMarkerStart.Length + segmentMarkerSeparator.Length
                + name.Length + segmentMarkerSeparator.Length
                + segmentId.Length + segmentMarkerSeparator.Length
                + segmentMarkerEnd.Length
            )
                .Append(segmentMarkerStart).Append(segmentMarkerSeparator)
                .Append(name).Append(segmentMarkerSeparator)
                .Append(segmentId).Append(segmentMarkerSeparator)
                .Append(segmentMarkerEnd)
                .ToString();
        }

        public string SegmentName { get; }

        public NewSegmentMarkerCommand(string[] arguments) : base(arguments)
        {
            SegmentName = arguments.GetArgument(1);
            int i = ContainsIllegalHtmlCommentString(SegmentName);
            if (0 <= i)
            {
                throw new ArgumentOutOfRangeException(
                    nameof(SegmentName),
                    SegmentName,
                    $"`{nameof(SegmentName)}` contains illegal HTML comment string: `{illegalHtmlCommentStrings[i]}`."
                );
            }
        }

        public override void Execute() => Console.WriteLine(GetSegmentMarker(SegmentName));
    }
}
