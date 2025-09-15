#!/usr/bin/env python

import pyutils.wrapper.libnotify as notify  # noqa: E402
def main():
  notify.send("Test",f"Testing",)

if __name__ == "__main__":
  main()
