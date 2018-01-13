# TEST.
discard """read hello
more X"""
import reactor/async, reactor/loop

proc main() {.async.} =
  let (input, output) = newInputOutputPair[byte]()
  let writeFut = output.write("\0\0\0\x05helloX")
  let data = await input.readChunkPrefixed()
  echo "read ", data
  let d = await input.read(1)
  echo "more ", d
  await writeFut

main().runMain()
