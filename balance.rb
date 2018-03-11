# encoding: utf-8
require_relative './balance_checker.rb'

balanceChecker = BalanceChecker.new
message = balanceChecker.getStat

exec "zenity --info --text=\"#{message}\"\nsleep 10"
