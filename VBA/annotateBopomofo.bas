
Sub annotateBopomofo()

    Dim enlarge As Integer: enlarge = 8

    Dim i As Integer

    Dim content As String

    Application.ScreenUpdating = False

    content = ""

    For Each char In Selection.Characters

        content = content + char + char

    Next char

    Selection.text = content

    For i = 1 To Selection.Characters.Count

        If i Mod 2 = 0 Then

            Selection.Characters(i).Font.Name = "¤å¹©ª`­µ¼e¦r"

            Selection.Characters(i).Font.Size = Selection.Characters(i - 1).Font.Size + enlarge

        End If

    Next

    i = 2

    Do While i <= Selection.Characters.Count

        If Selection.Characters(i).text = " " And Selection.Characters(i - 1).text = " " _
        Or Selection.Characters(i).text = "¡@" And Selection.Characters(i - 1).text = "¡@" _
        Or Selection.Characters(i).text = "¡A" And Selection.Characters(i - 1).text = "¡A" _
        Or Selection.Characters(i).text = "¡B" And Selection.Characters(i - 1).text = "¡B" _
        Or Selection.Characters(i).text = "¡C" And Selection.Characters(i - 1).text = "¡C" _
        Or Selection.Characters(i).text = "¡u" And Selection.Characters(i - 1).text = "¡u" _
        Or Selection.Characters(i).text = "¡v" And Selection.Characters(i - 1).text = "¡v" _
        Or Selection.Characters(i).text = "¡H" And Selection.Characters(i - 1).text = "¡H" Then

            Selection.Characters(i).Delete

        End If

        i = i + 1

    Loop

    Application.ScreenUpdating = True

End Sub
