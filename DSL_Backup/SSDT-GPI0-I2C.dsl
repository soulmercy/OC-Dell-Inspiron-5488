DefinitionBlock ("", "SSDT", 2, "DELL  ", "CBX3   ", 0x01072009)
{
    External (CBID, FieldUnitObj)
    External (GPDI, FieldUnitObj)
    External (OSYS, FieldUnitObj)
    External (TPDT, FieldUnitObj)
    External (TPDH, FieldUnitObj)
    External (TPDB, FieldUnitObj)
    External (TPDS, FieldUnitObj)
    External (_SB_.PCI0.HIDG, UnknownObj)
    External (_SB_.PCI0.TP7G, UnknownObj)
    External (_SB_.PCI0.TP7D, MethodObj)
    External (_SB_.SRXO, MethodObj)
    External (_SB_.GNUM, MethodObj)
    External (_SB_.INUM, MethodObj)
    External (_SB_.SHPO, MethodObj)
    External (_SB_.PCI0.I2CM, MethodObj)
    External (_SB_.PCI0.HIDD, MethodObj)
    External (TPDM, UnknownObj)
    External (_SB_.PCI0.I2C0.I2CX,UnknownObj)
    Scope (\)
{
    If (_OSI ("Darwin"))
    {
        TPDT = Zero
    }
}
External (_SB_.PCI0.I2C0, DeviceObj)


    Scope (_SB.PCI0.I2C0)
    {
    Device (TPXX)
        {
            Name (HID2, Zero)
            Name (SBFB, ResourceTemplate ()
            {
                I2cSerialBusV2 (0x0000, ControllerInitiated, 0x00061A80,
                    AddressingMode7Bit, "NULL",
                    0x00, ResourceConsumer, _Y38, Exclusive,
                    )
            })
            Name (SBFG, ResourceTemplate ()
            {
                GpioInt (Level, ActiveLow, ExclusiveAndWake, PullDefault, 0x0000,
                    "\\_SB.PCI0.GPI0", 0x00, ResourceConsumer, ,
                    )
                    {   // Pin list
                        0x0000
                    }
            })
            Name (SBFI, ResourceTemplate ()
            {
                Interrupt (ResourceConsumer, Level, ActiveLow, ExclusiveAndWake, ,, _Y39)
                {
                    0x00000000,
                }
            })
            CreateWordField (SBFB, \_SB.PCI0.I2C0.TPXX._Y38._ADR, BADR)  // _ADR: Address
            CreateDWordField (SBFB, \_SB.PCI0.I2C0.TPXX._Y38._SPE, SPED)  // _SPE: Speed
            CreateWordField (SBFG, 0x17, INT1)
            CreateDWordField (SBFI, \_SB.PCI0.I2C0.TPXX._Y39._INT, INT2)  // _INT: Interrupts
            Method (GTID, 1, Serialized)
            {
                If (Arg0)
                {
                    Switch (CBID)
                    {
                        Case (0x0896)
                        {
                            Return ("DELL0896")
                        }
                        Case (0x0895)
                        {
                            Return ("DELL0895")
                        }
                        Case (0x0894)
                        {
                            Return ("DELL0894")
                        }
                        Case (0x08A5)
                        {
                            Return ("DELL08A5")
                        }
                        Case (0x08A6)
                        {
                            Return ("DELL08A6")
                        }
                        Case (0x089C)
                        {
                            Return ("DELL089C")
                        }
                        Case (0x089D)
                        {
                            Return ("DELL089D")
                        }
                        Case (0x089E)
                        {
                            Return ("DELL089E")
                        }
                        Case (0x089F)
                        {
                            Return ("DELL089F")
                        }
                        Case (0x08A7)
                        {
                            Return ("DELL08A7")
                        }
                        Case (0x08A8)
                        {
                            Return ("DELL08A8")
                        }
                        Case (0x08A9)
                        {
                            Return ("DELL08A9")
                        }
                        Case (0x08BC)
                        {
                            Return ("DELL08BC")
                        }
                        Case (0x08BD)
                        {
                            Return ("DELL08BD")
                        }
                        Case (0x08C0)
                        {
                            Return ("DELL08C0")
                        }
                        Default
                        {
                            Return ("DELL089C")
                        }

                    }
                }
                Else
                {
                    Return (0x20)
                }
            }

            Method (_INI, 0, Serialized)  // _INI: Initialize
            {
                If ((OSYS < 0x07DC))
                {
                    SRXO (GPDI, One)
                }

                INT1 = GNUM (GPDI)
                INT2 = INUM (GPDI)
                If ((TPDM == Zero))
                {
                    SHPO (GPDI, One)
                }

                If ((TPDT == One))
                {
                    _HID = "SYNA2393"
                    HID2 = 0x20
                    Return (Zero)
                }

                If ((TPDT == 0x02))
                {
                    _HID = "06CB2846"
                    HID2 = 0x20
                    Return (Zero)
                }

                If ((TPDT == 0x06))
                {
                    _HID = "ALPS0000"
                    HID2 = 0x20
                    BADR = 0x2C
                    Return (Zero)
                }

                If ((TPDT == 0x05))
                {
                    _HID = GTID (One)
                    HID2 = TPDH /* \TPDH */
                    Switch (CBID)
                    {
                        Case (0x08BC)
                        {
                            BADR = 0x15
                        }
                        Case (0x08BD)
                        {
                            BADR = TPDB /* \TPDB */
                        }
                        Case (0x08C0)
                        {
                            BADR = TPDB /* \TPDB */
                        }
                        Default
                        {
                            BADR = TPDB /* \TPDB */
                        }

                    }

                    If ((TPDS == Zero))
                    {
                        SPED = 0x000186A0
                    }

                    If ((TPDS == One))
                    {
                        SPED = 0x00061A80
                    }

                    If ((TPDS == 0x02))
                    {
                        SPED = 0x000F4240
                    }

                    Return (Zero)
                }
            }

            Name (_HID, "XXXX0000")  // _HID: Hardware ID
            Name (_CID, "PNP0C50" /* HID Protocol Device (I2C bus) */)  // _CID: Compatible ID
            Name (_S0W, 0x03)  // _S0W: S0 Device Wake State
            Method (_DSM, 4, Serialized)  // _DSM: Device-Specific Method
            {
                If ((Arg0 == HIDG))
                {
                    Return (HIDD (Arg0, Arg1, Arg2, Arg3, HID2))
                }

                If ((Arg0 == TP7G))
                {
                    Return (TP7D (Arg0, Arg1, Arg2, Arg3, SBFB, SBFG))
                }

                Return (Buffer (One)
                {
                     0x00                                             // .
                })
            }

            Method (_STA, 0, NotSerialized)
{
    If (_OSI ("Darwin"))
    {
        Return (0x0F)
    }
    Else
    {
        Return (Zero)
    }
}

            Method (_CRS, 0, NotSerialized)  // _CRS: Current Resource Settings
            {


                    Return (ConcatenateResTemplate (I2CM (I2CX, BADR, SPED), SBFG))

            }
        }
    }
}