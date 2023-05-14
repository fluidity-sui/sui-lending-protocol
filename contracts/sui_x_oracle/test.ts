import * as path from "path";
import { networkType } from "sui-elements";

export { switchboardTestTxBuilder } from "./switchboard_rule/vendors/switchboard_std_test"
export const testAggregatorIds = require(path.join(__dirname, `./switchboard_rule/vendors/switchboard_std_test/switchboard-oracle.${networkType}.json`))

