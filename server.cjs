var __create = Object.create;
var __defProp = Object.defineProperty;
var __getOwnPropDesc = Object.getOwnPropertyDescriptor;
var __getOwnPropNames = Object.getOwnPropertyNames;
var __getProtoOf = Object.getPrototypeOf;
var __hasOwnProp = Object.prototype.hasOwnProperty;
var __copyProps = (to, from, except, desc) => {
  if (from && typeof from === "object" || typeof from === "function") {
    for (let key of __getOwnPropNames(from))
      if (!__hasOwnProp.call(to, key) && key !== except)
        __defProp(to, key, { get: () => from[key], enumerable: !(desc = __getOwnPropDesc(from, key)) || desc.enumerable });
  }
  return to;
};
var __toESM = (mod, isNodeMode, target) => (target = mod != null ? __create(__getProtoOf(mod)) : {}, __copyProps(
  // If the importer is in node compatibility mode or this is not an ESM
  // file that has been converted to a CommonJS file using a Babel-
  // compatible transform (i.e. "__esModule" has not been set), then set
  // "default" to the CommonJS "module.exports" for node compatibility.
  isNodeMode || !mod || !mod.__esModule ? __defProp(target, "default", { value: mod, enumerable: true }) : target,
  mod
));

// server.ts
var import_express = __toESM(require("express"), 1);
var import_path = __toESM(require("path"), 1);
var import_vite = require("vite");
var import_genai = require("@google/genai");
async function startServer() {
  const app = (0, import_express.default)();
  const PORT = 3e3;
  app.use(import_express.default.json({ limit: "10mb" }));
  const ai = new import_genai.GoogleGenAI({
    apiKey: process.env.GEMINI_API_KEY || "",
    httpOptions: {
      headers: {
        "User-Agent": "aistudio-build"
      }
    }
  });
  app.get("/api/health", (req, res) => {
    res.json({ status: "ok", institute: "Ashab Siraj Polytechnic Institute (ASPI)" });
  });
  app.post("/api/chat", async (req, res) => {
    try {
      const { message, lang = "bn" } = req.body;
      if (!message) {
        return res.status(400).json({ error: "Message is required" });
      }
      const systemPrompt = `You are the Official Virtual AI Assistant and Admission Helpdesk Officer for Ashab Siraj Polytechnic Institute (ASPI) (\u0986\u09B8\u09B9\u09BE\u09AC \u09B8\u09BF\u09B0\u09BE\u099C \u09AA\u09B2\u09BF\u099F\u09C7\u0995\u09A8\u09BF\u0995 \u0987\u09A8\u09B8\u09CD\u099F\u09BF\u099F\u09BF\u0989\u099F), website https://aspi.edu.bd.
Key Details about ASPI:
- BTEB Code: 70201. Approved by Bangladesh Technical Education Board & Ministry of Education.
- Principal: Muhammad Mazharul Islam Chowdhury (\u09AE\u09C1\u09B9\u09BE\u09AE\u09CD\u09AE\u09A6 \u09AE\u09BE\u099C\u09B9\u09BE\u09B0\u09C1\u09B2 \u0987\u09B8\u09B2\u09BE\u09AE \u099A\u09CC\u09A7\u09C1\u09B0\u09C0).
- Chairman: Ashab Siraj (\u0986\u09B8\u09B9\u09BE\u09AC \u09B8\u09BF\u09B0\u09BE\u099C).
- Location: Dhaka Campus: House 11/A, Road 92, Gulshan-2, Dhaka 1212. Phone: +880 1766-554433, +880 1912-345678. Email: info@aspi.edu.bd, ctgaspi@gmail.com. Chattogram Campus is also operational.
- Programs: 4-Year Diploma in Engineering (8 Semesters) in:
  1. Computer Science & Technology (CSE)
  2. Civil Technology
  3. Electrical Technology
  4. Electronics Technology
  5. Mechanical Technology
  6. Architecture Technology
  7. Basic Trade / Short Technical Courses
- Admission Eligibility: Passed SSC / Equivalent in any year with minimum GPA 2.00.
- Facilities: Modern Computer & Electronics Labs, Civil Total Station, AC Bus Transport, Library, Canteen, Student Clubs, 100% Job Placement Cell, B.Sc Credit Transfer with Presidency University & DUET.
- Response Style: Respond politely, encouragingly, and clearly in the user's language (${lang === "bn" ? "Bangla/\u09AC\u09BE\u0982\u09B2\u09BE" : "English"}). Keep answer informative, nicely structured with bullet points.`;
      const response = await ai.models.generateContent({
        model: "gemini-3.6-flash",
        contents: message,
        config: {
          systemInstruction: systemPrompt,
          temperature: 0.7
        }
      });
      const replyText = response.text || (lang === "bn" ? "\u09A6\u09C1\u0983\u0996\u09BF\u09A4, \u09AC\u09B0\u09CD\u09A4\u09AE\u09BE\u09A8\u09C7 \u09A4\u09A5\u09CD\u09AF \u09B8\u0982\u0997\u09CD\u09B0\u09B9 \u0995\u09B0\u09A4\u09C7 \u0995\u09BF\u099B\u09C1\u099F\u09BE \u09B8\u09AE\u09B8\u09CD\u09AF\u09BE \u09B9\u099A\u09CD\u099B\u09C7\u0964 \u0985\u09A8\u09C1\u0997\u09CD\u09B0\u09B9 \u0995\u09B0\u09C7 \u0986\u09AC\u09BE\u09B0 \u099A\u09C7\u09B7\u09CD\u099F\u09BE \u0995\u09B0\u09C1\u09A8\u0964" : "Apologies, unable to process request right now. Please try again.");
      return res.json({ reply: replyText });
    } catch (error) {
      console.error("Gemini Chat API Error:", error);
      return res.status(500).json({
        reply: "Ashab Siraj Polytechnic Institute (ASPI) Information Desk: Minimum SSC GPA 2.00 required for 4-year Diploma in Engineering. Campus: House 11/A, Road 92, Gulshan-2, Dhaka 1212. Phone: +880 1766-554433."
      });
    }
  });
  const applications = [];
  app.post("/api/apply", (req, res) => {
    try {
      const appData = req.body;
      const id = "ASPI-" + Math.floor(1e5 + Math.random() * 9e5);
      const newApp = {
        ...appData,
        id,
        appliedDate: (/* @__PURE__ */ new Date()).toISOString().split("T")[0],
        status: "Approved"
      };
      applications.push(newApp);
      res.json({ success: true, application: newApp });
    } catch (err) {
      res.status(500).json({ error: err.message });
    }
  });
  app.get("/api/applications", (req, res) => {
    res.json(applications);
  });
  if (process.env.NODE_ENV !== "production") {
    const vite = await (0, import_vite.createServer)({
      server: { middlewareMode: true },
      appType: "spa"
    });
    app.use(vite.middlewares);
  } else {
    const distPath = import_path.default.join(process.cwd(), "dist");
    app.use(import_express.default.static(distPath));
    app.get("*", (req, res) => {
      res.sendFile(import_path.default.join(distPath, "index.html"));
    });
  }
  app.listen(PORT, "0.0.0.0", () => {
    console.log(`ASPI Official Server running on http://localhost:${PORT}`);
  });
}
startServer();
//# sourceMappingURL=server.cjs.map
