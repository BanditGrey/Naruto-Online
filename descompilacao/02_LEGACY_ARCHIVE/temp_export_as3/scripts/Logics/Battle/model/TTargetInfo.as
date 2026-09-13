package Logics.Battle.model
{
   import Debugging.*;
   import Resources.Constants.CONST_BATTLE;
   import flash.utils.*;
   
   public class TTargetInfo
   {
      
      public static const CMD_NONE:int = 0;
      
      public static const CMD_ATTACK:int = 1;
      
      public static const CMD_ATTRBUFF:int = 2;
      
      public static const CMD_HURTBUFF:int = 3;
      
      public static const CMD_CONTROLBUFF:int = 4;
      
      public static const CMD_POSITION:int = 5;
      
      public static const CMD_STATUS:int = 6;
      
      public static const CMD_ATTACKEX:int = 7;
      
      public static const CMD_AllHertHp:int = 8;
      
      public static const CMD_NEW_SKILL:int = 9;
      
      public static const CMD_BUFF_TEXT:int = 10;
      
      public static const CMD_RELIVE:int = 11;
      
      public static const CMD_HurtHp:int = 12;
      
      public static const CMD_MIXRBUFF:int = 13;
      
      protected var FIndex:int;
      
      protected var FCMD:int;
      
      protected var FTargetCamp:int;
      
      protected var FTargetPos:int;
      
      protected var FTargetStatus:uint;
      
      protected var FReportTargetStatus:uint;
      
      protected var FResultInfo:TResultInfo;
      
      protected var FHealthGaining:int;
      
      protected var FAngerGaining:int;
      
      public var TargetStatus1:uint;
      
      public var ReportTargetStatus1:uint;
      
      public var TargetStatus2:uint;
      
      public function TTargetInfo(param1:int)
      {
         super();
         this.FIndex = param1;
         this.FResultInfo = new TResultInfo();
         this.FHealthGaining = 0;
         this.FAngerGaining = 0;
      }
      
      public function get Index() : int
      {
         return this.FIndex;
      }
      
      public function get CMD() : int
      {
         return this.FCMD;
      }
      
      public function set CMD(param1:int) : void
      {
         this.FCMD = param1;
      }
      
      public function get TargetCamp() : int
      {
         return this.FTargetCamp;
      }
      
      public function set TargetCamp(param1:int) : void
      {
         this.FTargetCamp = param1;
      }
      
      public function get TargetPos() : int
      {
         return this.FTargetPos;
      }
      
      public function set TargetPos(param1:int) : void
      {
         this.FTargetPos = param1;
      }
      
      public function get TargetStatus() : uint
      {
         return this.FTargetStatus;
      }
      
      public function set TargetStatus(param1:uint) : void
      {
         this.FTargetStatus = param1;
      }
      
      public function get ReportTargetStatus() : uint
      {
         return this.FReportTargetStatus;
      }
      
      public function set ReportTargetStatus(param1:uint) : void
      {
         this.FReportTargetStatus = param1;
      }
      
      public function get ResultInfo() : TResultInfo
      {
         return this.FResultInfo;
      }
      
      public function set ResultInfo(param1:TResultInfo) : void
      {
         this.FResultInfo = param1;
      }
      
      public function get HealthGaining() : uint
      {
         return this.FHealthGaining;
      }
      
      public function set HealthGaining(param1:uint) : void
      {
         this.FHealthGaining = param1;
      }
      
      public function get AngerGaining() : uint
      {
         return this.FAngerGaining;
      }
      
      public function set AngerGaining(param1:uint) : void
      {
         this.FAngerGaining = param1;
      }
      
      public function FillData() : void
      {
         this.FTargetStatus = this.FReportTargetStatus;
         this.TargetStatus1 = this.ReportTargetStatus1;
         this.FHealthGaining = 0;
         this.FAngerGaining = 0;
      }
      
      public function SetDataByObj(param1:Object) : void
      {
         var _loc2_:int = 0;
         this.FCMD = param1.CMD;
         this.FTargetCamp = param1.TargetCamp;
         this.FTargetPos = param1.TargetPos;
         this.FTargetStatus = param1.TargetStatus;
         this.FResultInfo.SetDataByObj(param1.Result);
      }
      
      public function toString() : String
      {
         var _loc1_:int = 0;
         var _loc2_:String = null;
         _loc2_ = "\n\t\t\t" + this.ResultInfo.toString();
         return "{ \"CMD\":" + this.CMD + ", \"TargetCamp\":" + this.TargetCamp + ", \"TargetPos\":" + this.TargetPos + ", \"TargetStatus\":0x" + this.ReportTargetStatus.toString(16) + ", \"TargetStatus1\":0x" + this.ReportTargetStatus1.toString(16) + ", \"Result\":" + _loc2_ + "}" + this.GetStatus();
      }
      
      public function GetStatus() : String
      {
         var _loc1_:String = "";
         if(this.FReportTargetStatus & CONST_BATTLE.ActiveType_NoAttack)
         {
            _loc1_ += "禁普攻 ";
         }
         if(this.FReportTargetStatus & CONST_BATTLE.ActiveType_Daze)
         {
            _loc1_ += "晕眩 ";
         }
         if(this.FReportTargetStatus & CONST_BATTLE.ActiveType_ImmCtrl)
         {
            _loc1_ += "免疫控制 ";
         }
         if(this.FReportTargetStatus & CONST_BATTLE.ActiveType_ImmCalm)
         {
            _loc1_ += "免疫降怒 ";
         }
         if(this.FReportTargetStatus & CONST_BATTLE.ActiveType_NoAddAnger)
         {
            _loc1_ += "禁怒 ";
         }
         if(this.FReportTargetStatus & CONST_BATTLE.ActiveType_NoSkill)
         {
            _loc1_ += "禁技 ";
         }
         if(this.FReportTargetStatus & CONST_BATTLE.ActiveType_NoAddHp)
         {
            _loc1_ += "禁回 ";
         }
         if(this.FReportTargetStatus & CONST_BATTLE.ActiveType_BeStone)
         {
            _loc1_ += "虚无 ";
         }
         if(this.FReportTargetStatus & CONST_BATTLE.ActiveType_Nothingness)
         {
            _loc1_ += "石化 ";
         }
         if(this.FReportTargetStatus & CONST_BATTLE.ActiveType_AllMiss)
         {
            _loc1_ += "超闪 ";
         }
         if(this.FReportTargetStatus & CONST_BATTLE.ActiveType_Confusion)
         {
            _loc1_ += "混乱 ";
         }
         if(this.FReportTargetStatus & CONST_BATTLE.ActiveType_Hit)
         {
            _loc1_ += "命中 ";
         }
         if(this.FReportTargetStatus & CONST_BATTLE.ActiveType_Crit)
         {
            _loc1_ += "暴击 ";
         }
         if(this.FReportTargetStatus & CONST_BATTLE.ActiveType_Block)
         {
            _loc1_ += "格档 ";
         }
         if(this.FReportTargetStatus & CONST_BATTLE.ActiveType_Help)
         {
            _loc1_ += "救援 ";
         }
         if(this.FReportTargetStatus & CONST_BATTLE.ActiveType_Punch)
         {
            _loc1_ += "合击 ";
         }
         if(this.FReportTargetStatus & CONST_BATTLE.ActiveType_Died)
         {
            _loc1_ += "死亡 ";
         }
         if(this.FReportTargetStatus & CONST_BATTLE.ActiveType_TargetEffect)
         {
            _loc1_ += "连锁目标 ";
         }
         if(this.FReportTargetStatus & CONST_BATTLE.ActiveType_ImmNoAnger)
         {
            _loc1_ += "免疫禁怒 ";
         }
         if(this.FReportTargetStatus & CONST_BATTLE.ActiveType_ImmNoSkill)
         {
            _loc1_ += "免疫禁技 ";
         }
         if(this.FReportTargetStatus & CONST_BATTLE.ActiveType_ImmNoHeal)
         {
            _loc1_ += "免疫禁回 ";
         }
         if(this.FReportTargetStatus & CONST_BATTLE.ActiveType_ImmStone)
         {
            _loc1_ += "免疫虚无 ";
         }
         if(this.FReportTargetStatus & CONST_BATTLE.ActiveType_ImmFake)
         {
            _loc1_ += "免疫石化 ";
         }
         if(this.FReportTargetStatus & CONST_BATTLE.ActiveType_ImmNoAttack)
         {
            _loc1_ += "免疫禁普攻 ";
         }
         if(this.FReportTargetStatus & CONST_BATTLE.ActiveType_ImmConfusion)
         {
            _loc1_ += "免疫混乱 ";
         }
         if(this.FReportTargetStatus & CONST_BATTLE.ActiveType_ImmAllMiss)
         {
            _loc1_ += "免疫超闪 ";
         }
         if(this.ReportTargetStatus1 & CONST_BATTLE.ActiveType_ImmCripple)
         {
            _loc1_ += "免疫残废 ";
         }
         if(this.ReportTargetStatus1 & CONST_BATTLE.ActiveType_ImmExpel)
         {
            _loc1_ += "免疫驱逐 ";
         }
         if(this.ReportTargetStatus1 & CONST_BATTLE.ActiveType_ImmParalysis)
         {
            _loc1_ += "免疫麻痹 ";
         }
         if(this.ReportTargetStatus1 & CONST_BATTLE.ActiveType_ImmBlind)
         {
            _loc1_ += "免疫致盲 ";
         }
         if(this.ReportTargetStatus1 & CONST_BATTLE.ActiveType_ImmBlind)
         {
            _loc1_ += "免疫月读 ";
         }
         if(this.ReportTargetStatus1 & CONST_BATTLE.ActiveType_ImmSeal)
         {
            _loc1_ += "免疫咒缚 ";
         }
         if(this.ReportTargetStatus1 & CONST_BATTLE.ActiveType_ImmSeal)
         {
            _loc1_ += "免疫禁锢 ";
         }
         if(this.ReportTargetStatus1 & CONST_BATTLE.ActiveType_ImmBengHuai)
         {
            _loc1_ += "免疫崩坏 ";
         }
         if(this.ReportTargetStatus1 & CONST_BATTLE.ActiveType_ImmIce)
         {
            _loc1_ += "免疫冰封 ";
         }
         if(this.FReportTargetStatus & CONST_BATTLE.ActiveType_FastMiss)
         {
            _loc1_ += "瞬闪 ";
         }
         if(this.FReportTargetStatus & CONST_BATTLE.ActiveType_ImmFastMiss)
         {
            _loc1_ += "免疫瞬闪 ";
         }
         if(this.ReportTargetStatus1 & CONST_BATTLE.ActiveType_ImmFengFu)
         {
            _loc1_ += "免疫风缚";
         }
         return _loc1_;
      }
   }
}

