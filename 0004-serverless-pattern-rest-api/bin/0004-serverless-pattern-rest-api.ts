#!/usr/bin/env node
import * as cdk from '@aws-cdk/core';
import { 0004ServerlessPatternRestApiStack } from '../lib/0004-serverless-pattern-rest-api-stack';

const app = new cdk.App();
new 0004ServerlessPatternRestApiStack(app, '0004ServerlessPatternRestApiStack');
