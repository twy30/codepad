namespace ConsoleApp
{
    public record SegmentMarker(string Start, string End)
    {
        const string Newline = "\n";

        public static readonly SegmentMarker Footer = new(
            Start:
                Newline
                + "    <!-- Footer BX~Z-53zLt2n+<7y)K,[bwNYbC[0LQ@EZ`~=PXO{9 -->" + Newline,
            End:
                "    <!-- Footer 2epmYU%}nzc@zvOZvZvU2I/!tW4iO/sNq+>9k^)RG -->" + Newline
        );

        public static readonly SegmentMarker HtmlLang = new(
            Start:
                Newline
                + "<!-- HtmlLang CcBpp/7GB\"XMD#c:5eBV,\\pX~Ha2W6P7_f,=m}+56 -->" + Newline
                + "<html lang=",
            End:
                ">" + Newline
                + "<!-- HtmlLang GZuB|*3;H=xg:B'Az2559~A<QK1EQ=;n<=wg,3pB\" -->" + Newline
        );

        public static readonly SegmentMarker HtmlTitle = new(
            Start:
                Newline
                + "    <!-- Title &*Id@2O~~c@j^]<YCh{8/t(DJ1\"+ilLm-1q-uvHrc -->" + Newline
                + "    <title>",
            End:
                "</title>" + Newline
                + "    <!-- Title mKDJo*fWc\"c1Iprcy%~UJdWAip)(.h/I%^\\Z>zbqm -->" + Newline
        );

        public static readonly SegmentMarker MarkdownInput = new(
            Start:
                Newline
                + "    <!-- MarkdownInput XUSmR^t4:hNGdI``s#T)Yt^'tt=)~TS#<JNY3#+v) -->" + Newline
                + "    <textarea id=\"Markdown-input\" cols=\"80\" rows=\"24\">" + Newline,
            End:
                "    </textarea>" + Newline
                + "    <!-- MarkdownInput tbDQ17gb%Fv[<K9b7j9Iikei1qIWJ@H32PkobmOby -->" + Newline
        );

        public static readonly SegmentMarker MarkdownTitle = new(
            Start:
                MarkdownInput.Start
                + "# ",
            End:
                Newline
        );

        public static readonly SegmentMarker TableOfContents = new(
            Start:
                Newline
                + "<!-- TableOfContents }<N#JA0{zK8GAhFqg,i-j8Sb}TA\"zdzz\\N]rQ^{yA -->" + Newline,
            End:
                "<!-- TableOfContents j?17mGiiN35qa{N\"RcQ~fx4J@<V3C&cjmdi0N&tKl -->" + Newline
        );
    }
}
