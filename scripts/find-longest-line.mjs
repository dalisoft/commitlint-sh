import { readFile } from "node:fs/promises";
import { text } from "node:stream/consumers";

const log = await text(process.stdin);

const minMsToTrace = 3;

const diffs = log
  .split("\n")
  .map((line, i) => [line, i + 1])
  .filter(([line]) => line.charAt(0) === "+")
  .map(([line, ln], index, logs) => {
    const prevEpochTime = +logs[index - 1]?.[0]
      ?.replace(/\+/g, "")
      ?.trim()
      ?.split(" ")?.[0];
    const epochTime = +line.replace(/\+/g, "").trim().split(" ")[0];
    const diff = index > 0 ? epochTime - prevEpochTime : 0;

    return [diff, line.split("\t")[1]?.trim(), ln];
  });
const sumdiff = diffs.reduce((acc, [diff]) => acc + diff, 0);
const maxdiff = diffs.reduce(
  (acc, [diff, line]) => {
    return diff > acc.diff ? { diff, line: line } : acc;
  },
  { diff: 0 }
);
const diffs_sorted = diffs.filter(([diff]) => diff >= minMsToTrace);

console.log("Total ms for script", sumdiff);
console.log("Most expensive line", `${maxdiff.diff}ms   ${maxdiff.line}`);

console.table(
  diffs_sorted.map(([diff, line, ln]) => ({
    ms: diff,
    line_number: ln,
    line: line.slice(0, 72) + " ...",
  }))
);
