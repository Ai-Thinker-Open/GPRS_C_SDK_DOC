ICCID(Integrate circuit card identity )
===

ICCD is the unique identification of the SIM card with a length of 20.
example:[demo/iccid](https://github.com/Ai-Thinker-Open/GPRS_C_SDK/blob/master/demo/iccid/src/demo_iccid.c)

## Function

### SIM_GetICCID

```c
bool SIM_GetICCID(uint8_t* iccid);
```

#### Function

Get the ICCID value of the SIM card

#### Parameters

* iccid：The location of the obtained iccid value storage, the length of the array should >= 20

#### Return

* Whether the ICCID value is successfully acquired or not, if not please check if the card is inserted.

