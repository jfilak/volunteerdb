package main

import (
    "os"
    "flag"
    "fmt"
    "log"
    "net/http"
)

func main() {
    portPtr := flag.Int("port", 8000, "TCP port to listen on. Defaults to 8000.")
    flag.Parse()

    if *portPtr < 1 || *portPtr > 65535 {
        fmt.Fprintln(os.Stderr, "Specified port is out of the range <1,65535>: %d", *portPtr)
        os.Exit(1)
    }

    http.HandleFunc("/version", HandleVersion)

    host := fmt.Sprintf(":%d", *portPtr)
    fmt.Printf("Listening and Serving on '%s'\n", host)
    log.Fatal(http.ListenAndServe(host, nil))
}
