package com.example.sslcquiz

import android.content.Context
import android.graphics.*
import android.graphics.pdf.PdfDocument
import android.text.Layout
import android.text.StaticLayout
import android.text.TextPaint
import java.io.File
import java.io.FileOutputStream
object TamilPdfGenerator {
    fun generate(context: Context, data: Map<String, Any>): String {

        val file = File(context.cacheDir, "quiz_tamil.pdf")

        val document = PdfDocument()
        val paint = Paint(Paint.ANTI_ALIAS_FLAG)

        val typeface = Typeface.createFromAsset(
            context.assets,
            "fonts/NotoSansTamil-Regular.ttf"
        )

        paint.typeface = typeface

        var pageNumber = 1
        var y = 60

        val pageWidth = 595
        val tamil = data["tamil"] as? Boolean ?: false
        val margin = 40
        val contentWidth = pageWidth - margin * 2

        fun newPage(): Pair<PdfDocument.Page, Canvas> {
            val pageInfo = PdfDocument.PageInfo.Builder(595, 842, pageNumber).create()
            val page = document.startPage(pageInfo)
            return Pair(page, page.canvas)
        }

        var (page, canvas) = newPage()

        /* ---------- TEXT WRAP FUNCTION ---------- */

        fun drawWrappedText(
            text: String,
            x: Float,
            yPos: Int,
            width: Int,
            textSize: Float,
            isBold: Boolean = false
        ): Int {

            val textPaint = TextPaint()
            textPaint.isAntiAlias = true
            textPaint.textSize = textSize
            textPaint.typeface = typeface
            textPaint.color = paint.color

            if (isBold) {
                textPaint.typeface = Typeface.create(typeface, Typeface.BOLD)
            }

            val staticLayout = StaticLayout.Builder
                .obtain(text, 0, text.length, textPaint, width)
                .setAlignment(Layout.Alignment.ALIGN_NORMAL)
                .setLineSpacing(0f, 1f)
                .setIncludePad(false)
                .build()

            canvas.save()
            canvas.translate(x, yPos.toFloat())
            staticLayout.draw(canvas)
            canvas.restore()

            return staticLayout.height
        }

        /* ---------- HEADER ---------- */

        paint.textSize = 22f
        paint.isFakeBoldText = true
        paint.color = android.graphics.Color.rgb(25, 70, 145)

        val title = if (tamil) "வினா தேர்வு அறிக்கை" else "Quiz Report"


        canvas.drawText(title, margin.toFloat(), y.toFloat(), paint)

        y += 10

        canvas.drawLine(
            margin.toFloat(),
            (y + 10).toFloat(),
            (pageWidth - margin).toFloat(),
            (y + 10).toFloat(),
            paint
        )

        y += 30

        /* ---------- METADATA ---------- */

        paint.textSize = 13f
        paint.isFakeBoldText = false
        paint.color = android.graphics.Color.BLACK

        val name = if (tamil) "பெயர்" else "Name"
        val lesson = if (tamil) "பாடம்" else "Lesson"


        canvas.drawText("$name: ${data["name"]}", margin.toFloat(), y.toFloat(), paint)
        canvas.drawText("$lesson: ${data["lesson"]} (${data["medium"]} ${if (tamil) "நடுத்தர" else "Medium"},${data["subject"]})", 330f, y.toFloat(), paint)

        y += 18

        val duration = if (tamil) "நேரம்" else "Duration"
        val date = if (tamil) "தேதி" else "Date"


        canvas.drawText("$duration: ${data["duration"]}", margin.toFloat(), y.toFloat(), paint)
        canvas.drawText("$date: ${data["date"]}", 330f, y.toFloat(), paint)

        y += 30

        /* ---------- SCORE BOX ---------- */

        val boxHeight = 70

        paint.color = android.graphics.Color.rgb(230, 240, 255)
        canvas.drawRect(
            margin.toFloat(),
            y.toFloat(),
            (pageWidth - margin).toFloat(),
            (y + boxHeight).toFloat(),
            paint
        )
        val basePaint = Paint(Paint.ANTI_ALIAS_FLAG)

        paint.color = android.graphics.Color.rgb(150, 190, 240)
        paint.style = Paint.Style.STROKE

        canvas.drawRect(
            margin.toFloat(),
            y.toFloat(),
            (pageWidth - margin).toFloat(),
            (y + boxHeight).toFloat(),
            paint
        )

        paint.style = Paint.Style.FILL

        val colWidth = contentWidth / 4

        paint.color = android.graphics.Color.BLACK
        paint.textSize = 14f

        val total = if (tamil) "மொத்தம்" else "Total Question"
        val correct = if (tamil) "சரி" else "Correct"
        val wrong = if (tamil) "தவறு" else "Wrong"
        val score = if (tamil) "மதிப்பெண்" else "Score"

        canvas.drawText(total, margin + 10f, (y + 25).toFloat(), paint)
        canvas.drawText("${data["total"]}", margin + 10f, (y + 45).toFloat(), paint)

        canvas.drawText(correct, (margin + colWidth + 10).toFloat(), (y + 25).toFloat(), paint)
        canvas.drawText("${data["correct"]}", (margin + colWidth + 10).toFloat(), (y + 45).toFloat(), paint)

        canvas.drawText(wrong, (margin + colWidth * 2 + 10).toFloat(), (y + 25).toFloat(), paint)
        canvas.drawText("${data["wrong"]}", (margin + colWidth * 2 + 10).toFloat(), (y + 45).toFloat(), paint)

        canvas.drawText(score, (margin + colWidth * 3 + 10).toFloat(), (y + 25).toFloat(), paint)
        canvas.drawText("${data["score"]}", (margin + colWidth * 3 + 10).toFloat(), (y + 45).toFloat(), paint)

        y += boxHeight + 40

        /* ---------- SECTION TITLE ---------- */

        paint.textSize = 16f
        paint.isFakeBoldText = true
        paint.color = android.graphics.Color.rgb(25, 70, 145)


        val review = if (tamil) "வினா மதிப்பாய்வு" else "Quiz Review"

        canvas.drawText(review, margin.toFloat(), y.toFloat(), paint)

        y += 30

        /* ---------- QUESTIONS ---------- */

        val questions = data["questions"] as List<Map<String, String>>

        for ((index, q) in questions.withIndex()) {

            if (y > 760) {
                document.finishPage(page)
                pageNumber++
                val pair = newPage()
                page = pair.first
                canvas = pair.second
                y = 60
            }

            paint.color = android.graphics.Color.BLACK
            val imageBytes = q["image_question"] as? ByteArray

            val questionText = if (imageBytes == null) {
                "${index + 1}. ${q["question"]}"
            } else {
                ""
            }

            val questionHeight = drawWrappedText(
                questionText ,
                margin.toFloat(),
                y,
                contentWidth,
                14f,
                true
            )




            if (imageBytes != null) {


                val bitmap = BitmapFactory.decodeByteArray(imageBytes, 0, imageBytes.size)

                val imageWidth = (contentWidth * 0.4).toInt()
                val textWidth = contentWidth - imageWidth - 10

                val scale = imageWidth.toFloat() / bitmap.width
                val imageHeight = (bitmap.height * scale).toInt()

                val questionHeight = drawWrappedText(
                    questionText,
                    margin.toFloat(),
                    y,
                    textWidth,
                    14f,
                    true
                )

                val rowHeight = maxOf(questionHeight, imageHeight)

                // check page break
                if (y + rowHeight > 750) {
                    document.finishPage(page)
                    pageNumber++

                    val pair = newPage()
                    page = pair.first
                    canvas = pair.second
                    y = 60
                }

                // draw text (left side)
                drawWrappedText(
                    "${index + 1}.",
                    margin.toFloat(),
                    y,
                    textWidth,
                    14f,
                    true
                )

                val scaledBitmap = Bitmap.createScaledBitmap(
                    bitmap,
                    imageWidth,
                    imageHeight,
                    true
                )
                val gap = 10f
                val imageX = margin + textWidth  + gap

                canvas.drawBitmap(
                    scaledBitmap,
                    margin.toFloat() + 20,
                    y.toFloat(),
                    basePaint
                )

                y += rowHeight + 10
            }



            y += questionHeight + 10

            paint.color = android.graphics.Color.rgb(0, 130, 0)
            val correctBytes = q["correct_image"] as? ByteArray
            val correctAns = if (correctBytes == null) {
                "${q["correct"]}"
            } else {
                ""
            }
            val cAnswer = if (tamil) "சரி பதில்" else "Correct Answer"

            val correctHeight = drawWrappedText(
                "$cAnswer: ${correctAns}",
                (margin).toFloat(),
                y,
                contentWidth - 15,
                13f
            )

            if (correctBytes != null) {

                val bitmap = BitmapFactory.decodeByteArray(correctBytes, 0, correctBytes.size)

                val maxWidth = 120
                val targetWidth = (contentWidth * 0.19).toInt()
                val scale = targetWidth.toFloat() / bitmap.width
                val scaledHeight = (bitmap.height * scale).toInt()

                if (y + scaledHeight > 750) {
                    document.finishPage(page)
                    pageNumber++

                    val pair = newPage()
                    page = pair.first
                    canvas = pair.second
                    y = 60
                }

                val scaledBitmap = Bitmap.createScaledBitmap(
                    bitmap,
                    targetWidth,
                    scaledHeight,
                    true
                )

                val x = margin + (contentWidth - targetWidth) / 2

                canvas.drawBitmap(
                    scaledBitmap,
                    (margin+100).toFloat(),
                    y.toFloat() ,
                    basePaint
                )

                y += scaledHeight + 10
            }


            y += correctHeight + 6

            paint.color = android.graphics.Color.rgb(180, 0, 0)

            val userAnswer = q["userAnswer"] as? Boolean


            if(userAnswer == false){


                val wAnswer = if (tamil) "உங்கள் பதில்" else "Wrong Answer"
                val wBytes = q["wrong_image"] as? ByteArray
                val wAns = if (wBytes == null) {
                    "${q["user"]}"
                } else {
                    ""
                }
                val userHeight = drawWrappedText(
                    "$wAnswer: ${wAns}",
                    (margin).toFloat(),
                    y,
                    contentWidth - 15,
                    13f
                )


                if (wBytes != null) {

                    val bitmap = BitmapFactory.decodeByteArray(wBytes, 0, wBytes.size)

                    val maxWidth = 120
                    val targetWidth = (contentWidth *0.19).toInt()
                    val scale = targetWidth.toFloat() / bitmap.width
                    val scaledHeight = (bitmap.height * scale).toInt()

                    if (y + scaledHeight > 750) {
                        document.finishPage(page)
                        pageNumber++

                        val pair = newPage()
                        page = pair.first
                        canvas = pair.second
                        y = 60
                    }

                    val scaledBitmap = Bitmap.createScaledBitmap(
                        bitmap,
                        targetWidth,
                        scaledHeight,
                        true
                    )

                    val x = margin + (contentWidth - targetWidth) / 2

                    canvas.drawBitmap(
                        scaledBitmap,
                        (margin+100).toFloat(),
                        y.toFloat(),
                        basePaint
                    )

                    y += scaledHeight + 10
                }

                y += userHeight + 20
            }






        }

        document.finishPage(page)

        document.writeTo(FileOutputStream(file))
        document.close()

        return file.absolutePath
    }


//
//    fun generate(context: Context, data: Map<String, Any>): String {
//
//        val file = File(context.cacheDir, "quiz_tamil.pdf")
//        val document = PdfDocument()
//
//        val basePaint = Paint(Paint.ANTI_ALIAS_FLAG)
//
//        val baseTypeface = Typeface.createFromAsset(
//            context.assets,
//            "fonts/NotoSansTamil-Regular.ttf"
//        )
//
//        basePaint.typeface = baseTypeface
//
//        var pageNumber = 1
//        var y = 60
//
//        val pageWidth = 595
//        val margin = 40
//        val contentWidth = pageWidth - margin * 2
//
//        val tamil = data["tamil"] as? Boolean ?: false
//
//        fun newPage(): Pair<PdfDocument.Page, Canvas> {
//            val pageInfo = PdfDocument.PageInfo.Builder(595, 842, pageNumber).create()
//            val page = document.startPage(pageInfo)
//            return Pair(page, page.canvas)
//        }
//
//        var page: PdfDocument.Page
//        var canvas: Canvas
//
//        var pair = newPage()
//        page = pair.first
//        canvas = pair.second
//
//        /* ---------- TEXT WRAP ---------- */
//
//        fun drawWrappedText(
//            text: String,
//            x: Float,
//            yPos: Int,
//            width: Int,
//            textSize: Float,
//            isBold: Boolean = false,
//            color: Int = Color.BLACK
//        ): Int {
//
//            val textPaint = TextPaint().apply {
//                isAntiAlias = true
//                this.textSize = textSize
//                this.color = color
//
//                val finalTypeface = if (isBold)
//                    Typeface.create(baseTypeface, Typeface.BOLD)
//                else
//                    baseTypeface
//
//                typeface = finalTypeface
//            }
//
//            val layout = StaticLayout.Builder
//                .obtain(text, 0, text.length, textPaint, width)
//                .setAlignment(Layout.Alignment.ALIGN_NORMAL)
//                .setLineSpacing(0f, 1f)
//                .setIncludePad(false)
//                .build()
//
//            canvas.save()
//            canvas.translate(x, yPos.toFloat())
//            layout.draw(canvas)
//            canvas.restore()
//
//            return layout.height
//        }
//
//        /* ---------- TITLE ---------- */
//
//        val title = if (tamil) "வினா தேர்வு அறிக்கை" else "Quiz Report"
//
//        drawWrappedText(
//            title,
//            margin.toFloat(),
//            y,
//            contentWidth,
//            22f,
//            true,
//            Color.rgb(25, 70, 145)
//        )
//
//        y += 35
//
//        /* ---------- HEADER BOX ---------- */
//
//        val name = data["name"]?.toString() ?: ""
//        val lesson = data["lesson"]?.toString() ?: ""
//        val duration = data["duration"]?.toString() ?: ""
//        val date = data["date"]?.toString() ?: ""
//        val medium = data["medium"]?.toString() ?: ""
//        val subject = data["subject"]?.toString() ?: ""
//
//        val boxHeight = 70
//
//        basePaint.style = Paint.Style.FILL
//        basePaint.color = Color.rgb(240, 245, 255)
//
//        canvas.drawRect(
//            margin.toFloat(),
//            y.toFloat(),
//            (pageWidth - margin).toFloat(),
//            (y + boxHeight).toFloat(),
//            basePaint
//        )
//
//        basePaint.style = Paint.Style.STROKE
//        basePaint.color = Color.rgb(150, 180, 220)
//
//        canvas.drawRect(
//            margin.toFloat(),
//            y.toFloat(),
//            (pageWidth - margin).toFloat(),
//            (y + boxHeight).toFloat(),
//            basePaint
//        )
//
//        basePaint.style = Paint.Style.FILL
//        basePaint.color = Color.BLACK
//        basePaint.textSize = 13f
//
//        canvas.drawText("Name: $name", margin + 10f, y + 25f, basePaint)
//        canvas.drawText("Lesson: $lesson ($medium, $subject)", margin + 250f, y + 25f, basePaint)
//
//        canvas.drawText("Duration: $duration", margin + 10f, y + 50f, basePaint)
//        canvas.drawText("Date: $date", margin + 250f, y + 50f, basePaint)
//
//        y += boxHeight + 20
//
//        /* ---------- SAFE QUESTIONS CAST ---------- */
//
//        val questions: List<Map<String, Any>> =
//            (data["questions"] as? List<*>)?.mapNotNull {
//                it as? Map<String, Any>
//            } ?: emptyList()
//
//        /* ---------- QUESTIONS LOOP ---------- */
//
//        for ((index, q) in questions.withIndex()) {
//
//            if (y > 750) {
//                document.finishPage(page)
//                pageNumber++
//
//                pair = newPage()
//                page = pair.first
//                canvas = pair.second
//                y = 60
//            }
//
//            val questionText = "${index + 1}. ${q["question"] ?: ""}"
//
//            val questionHeight = drawWrappedText(
//                questionText,
//                margin.toFloat(),
//                y,
//                contentWidth,
//                14f,
//                true
//            )
//
//            y += questionHeight + 10
//
//            /* ---------- IMAGE ---------- */
//
//            val imageBytes = q["image_question"] as? ByteArray
//
//            if (imageBytes != null) {
//
//                val bitmap = BitmapFactory.decodeByteArray(imageBytes, 0, imageBytes.size)
//
//                val targetWidth = (contentWidth * 0.6).toInt()
//                val scale = targetWidth.toFloat() / bitmap.width
//                val scaledHeight = (bitmap.height * scale).toInt()
//
//                if (y + scaledHeight > 750) {
//                    document.finishPage(page)
//                    pageNumber++
//
//                    pair = newPage()
//                    page = pair.first
//                    canvas = pair.second
//                    y = 60
//                }
//
//                val scaledBitmap = Bitmap.createScaledBitmap(
//                    bitmap,
//                    targetWidth,
//                    scaledHeight,
//                    true
//                )
//
//                val x = margin + (contentWidth - targetWidth) / 2
//
//                canvas.drawBitmap(
//                    scaledBitmap,
//                    x.toFloat(),
//                    y.toFloat(),
//                    basePaint
//                )
//
//                y += scaledHeight + 10
//            }
//
//            /* ---------- OPTIONS ---------- */
//
//            val options = listOf("option1", "option2", "option3", "option4")
//
//            for (opt in options) {
//
//                val optText = q[opt]?.toString() ?: ""
//
//                if (optText.isNotEmpty()) {
//                    val h = drawWrappedText(
//                        "• $optText",
//                        margin.toFloat(),
//                        y,
//                        contentWidth,
//                        13f
//                    )
//                    y += h + 5
//                }
//            }
//
//            /* ---------- ANSWERS ---------- */
//
//            val correctText = if (tamil)
//                "சரி: ${q["correct"]}"
//            else
//                "Correct: ${q["correct"]}"
//
//            val userText = if (tamil)
//                "உங்கள் பதில்: ${q["user"]}"
//            else
//                "Your Answer: ${q["user"]}"
//
//            val correctHeight = drawWrappedText(
//                correctText,
//                margin.toFloat(),
//                y,
//                contentWidth,
//                13f,
//                false,
//                Color.rgb(0, 130, 0)
//            )
//
//            y += correctHeight + 5
//
//            val userHeight = drawWrappedText(
//                userText,
//                margin.toFloat(),
//                y,
//                contentWidth,
//                13f,
//                false,
//                Color.rgb(180, 0, 0)
//            )
//
//            y += userHeight + 20
//        }
//
//        document.finishPage(page)
//        document.writeTo(FileOutputStream(file))
//        document.close()
//
//        return file.absolutePath
//    }

}
