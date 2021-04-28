import 'package:business_banking/features/deposit_check/bloc/deposit_check_card_usecase.dart';
import 'package:business_banking/features/deposit_check/bloc/deposit_check_confirmation_usecase.dart';
import 'package:business_banking/features/deposit_check/bloc/deposit_check_usecase.dart';
import 'package:mockito/mockito.dart';

class MockDepositCheckCardBlockMock extends Mock
    implements DepositCheckCardUseCase {}

class MockDepositCheckBlockMock extends Mock implements DepositCheckUseCase {}

class MockDepositCheckConfirmBlockMock extends Mock
    implements DepositCheckConfirmUseCase {}
