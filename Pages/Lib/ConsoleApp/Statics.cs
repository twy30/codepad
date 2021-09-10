using System;
using System.Collections.Generic;
using System.IO;
using System.Text;
using System.Text.RegularExpressions;
using ConsoleApp.Commands;

namespace ConsoleApp
{
    public static class Statics
    {
        static readonly Dictionary<SegmentMarker[], Regex> parserCache = new();
        static readonly Dictionary<string, string> escapedStringCache = new();

        public static string GetArgument(this string[] arguments, int index)
        {
            if (index < 0 || arguments.Length <= index)
            {
                throw new ArgumentOutOfRangeException(
                    nameof(index),
                    index,
                    $"Invalid argument index (max: {arguments.Length})."
                );
            }
            return arguments[index];
        }

        public static void ThrowIfNotRegularFile(string argumentName, params string[] paths)
        {
            foreach (var path in paths)
            {
                if (!File.Exists(path))
                {
                    throw new ArgumentOutOfRangeException(
                        argumentName,
                        path,
                        "Not a regular file."
                    );
                }
            }
        }

        public static AbstractCommand GetCommand(string name, string[] arguments)
        {
            var fullName = typeof(AbstractCommand).FullName!;
            fullName = fullName.Substring(0, fullName.LastIndexOf(Type.Delimiter)) + Type.Delimiter + name + "Command";
            var type = Type.GetType(fullName, throwOnError: false, ignoreCase: true);
            if (type == null)
            {
                throw new ArgumentOutOfRangeException(
                    nameof(name),
                    name,
                    "Invalid command name."
                );
            }
            return (AbstractCommand)Activator.CreateInstance(type, (object)arguments)!;
        }

        public static
        (
            string pageStart,
            IDictionary<SegmentMarker, string> segmentContents,
            IDictionary<SegmentMarker, string> segmentEnds
        )
        ParsePage(string contents, params SegmentMarker[] markers)
        {
            if (!parserCache.TryGetValue(markers, out Regex? parser))
            {
                var regexBuilder = new StringBuilder();
                regexBuilder.Append("^");
                AppendLazyRegex(string.Empty, markers[0].Start);
                int lastMarkerIndex = markers.Length - 1;
                const string contentsRegex = "(.*?)";
                for (var i = 0; i < lastMarkerIndex; ++i)
                {
                    regexBuilder.Append(contentsRegex);
                    AppendLazyRegex(markers[i].End, markers[i + 1].Start);
                }
                regexBuilder.Append(contentsRegex);
                AppendGreedyRegex(markers[lastMarkerIndex].End, string.Empty);
                regexBuilder.Append("$");
                parser = new(regexBuilder.ToString(), RegexOptions.CultureInvariant | RegexOptions.Singleline);
                parserCache[markers] = parser;

                void AppendGreedyRegex(string start, string end) => AppendRegex(start, ".*", end);

                void AppendLazyRegex(string start, string end) => AppendRegex(start, ".*?", end);

                void AppendRegex(string start, string regex, string end)
                {
                    regexBuilder
                        .Append("(")
                        .Append(Escape(start))
                        .Append(regex)
                        .Append(Escape(end))
                        .Append(")");
                }

                string Escape(string @string)
                {
                    if (!escapedStringCache.TryGetValue(@string, out string? escapedString))
                    {
                        escapedString = Regex.Escape(@string);
                        escapedStringCache[@string] = escapedString;
                    }
                    return escapedString;
                }
            }
            var matches = parser.Matches(contents);
            if (matches.Count != 1)
            {
                throw new ArgumentException($"`{nameof(contents)}` and `{nameof(markers)}` must uniquely match.");
            }
            var match = matches[0];
            var segmentContents = new Dictionary<SegmentMarker, string>();
            var segmentEnds = new Dictionary<SegmentMarker, string>();
            for (var i = 0; i < markers.Length; ++i)
            {
                var groupIndex = (i + 1) * 2;
                var marker = markers[i];
                segmentContents[marker] = match.Groups[groupIndex].Value;
                segmentEnds[marker] = match.Groups[groupIndex + 1].Value;
            }
            return (match.Groups[1].Value, segmentContents, segmentEnds);
        }
    }
}
