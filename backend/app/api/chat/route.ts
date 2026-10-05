import { NextResponse } from "next/server";

export async function POST(request: Request) {
  try {
    const body = await request.json();
    const message = body.message;

    if (!message || typeof message !== "string") {
      return NextResponse.json(
        { error: "Message is required" },
        { status: 400 }
      );
    }

    const ollamaResponse = await fetch(
      "http://localhost:11434/api/chat",
      {
        method: "POST",
        headers: {
          "Content-Type": "application/json",
        },
        body: JSON.stringify({
          model: "qwen3:8b",
          messages: [
            {
              role: "user",
              content: message,
            },
          ],
          stream: false,
        }),
      }
    );

    if (!ollamaResponse.ok) {
      throw new Error("Ollama request failed");
    }

    const data = await ollamaResponse.json();

    return NextResponse.json({
      message: data.message.content,
    });
  } catch (error) {
    console.error(error);

    return NextResponse.json(
      {
        error: "Failed to get response from AI",
      },
      { status: 500 }
    );
  }
}