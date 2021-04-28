import 'package:business_banking/features/deposit_check/bloc/deposit_check_card_usecase.dart';
import 'package:business_banking/features/deposit_check/bloc/deposit_check_confirmation_usecase.dart';
import 'package:business_banking/features/deposit_check/bloc/deposit_check_usecase.dart';
import 'package:mockito/mockito.dart';

class MockDepositCheckCardUseCase extends Mock
    implements DepositCheckCardUseCase {}

class MockDepositCheckUseCase extends Mock implements DepositCheckUseCase {}

class MockDepositCheckConfirmUseCase extends Mock
    implements DepositCheckConfirmUseCase {}
