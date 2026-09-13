package Logics.Organization
{
   import Foundation.Common.Integer.UInt64;
   import Foundation.SensitiveWord.SSensitiveWord;
   import Logics.Organization.TreasureTree.TBasicTreasureTree;
   
   public class TBaseOrganization
   {
      
      protected var FOrgId:uint;
      
      protected var FOrgFamily:uint;
      
      protected var FOrgName:String;
      
      protected var FMasterName:String;
      
      protected var FOrgLevel:uint;
      
      protected var FOrgMoney:int;
      
      protected var FOrgMembers:uint;
      
      protected var FOrgContribution:int;
      
      protected var FSelfContribution:int;
      
      protected var FOrgExploit:UInt64;
      
      protected var FOrgPower:uint;
      
      protected var FOrgNotice:String;
      
      protected var FOrgAddition:Vector.<Object>;
      
      protected var FMoneyAddition:uint;
      
      protected var FExpAddition:uint;
      
      protected var FOrgMaxMemberCount:uint;
      
      protected var FOrgCampData:Vector.<Object>;
      
      protected var FOrgActivityStatus:Vector.<Object>;
      
      protected var FBasicTreasureTree:TBasicTreasureTree;
      
      public function TBaseOrganization()
      {
         super();
         this.FBasicTreasureTree = new TBasicTreasureTree();
         this.FOrgExploit = new UInt64();
      }
      
      public function get OrgId() : uint
      {
         return this.FOrgId;
      }
      
      public function set OrgId(param1:uint) : void
      {
         this.FOrgId = param1;
      }
      
      public function get OrgFamily() : uint
      {
         return this.FOrgFamily;
      }
      
      public function set OrgFamily(param1:uint) : void
      {
         this.FOrgFamily = param1;
      }
      
      public function get OrgName() : String
      {
         return SSensitiveWord.Filter(this.FOrgName);
      }
      
      public function set OrgName(param1:String) : void
      {
         this.FOrgName = param1;
      }
      
      public function get MasterName() : String
      {
         return SSensitiveWord.Filter(this.FMasterName);
      }
      
      public function set MasterName(param1:String) : void
      {
         this.FMasterName = param1;
      }
      
      public function get OrgLevel() : uint
      {
         return this.FOrgLevel;
      }
      
      public function set OrgLevel(param1:uint) : void
      {
         this.FOrgLevel = param1;
      }
      
      public function get OrgMoney() : int
      {
         return this.FOrgMoney;
      }
      
      public function set OrgMoney(param1:int) : void
      {
         this.FOrgMoney = param1;
      }
      
      public function get OrgMembers() : uint
      {
         return this.FOrgMembers;
      }
      
      public function set OrgMembers(param1:uint) : void
      {
         this.FOrgMembers = param1;
      }
      
      public function get OrgContribution() : int
      {
         return this.FOrgContribution;
      }
      
      public function set OrgContribution(param1:int) : void
      {
         this.FOrgContribution = param1;
      }
      
      public function get SelfContribution() : int
      {
         return this.FSelfContribution;
      }
      
      public function set SelfContribution(param1:int) : void
      {
         this.FSelfContribution = param1;
      }
      
      public function get OrgExploit() : UInt64
      {
         return this.FOrgExploit;
      }
      
      public function set OrgExploit(param1:UInt64) : void
      {
         this.FOrgExploit = param1;
      }
      
      public function get OrgPower() : uint
      {
         return this.FOrgPower;
      }
      
      public function set OrgPower(param1:uint) : void
      {
         this.FOrgPower = param1;
      }
      
      public function get OrgNotice() : String
      {
         return SSensitiveWord.Filter(this.FOrgNotice);
      }
      
      public function set OrgNotice(param1:String) : void
      {
         this.FOrgNotice = param1;
      }
      
      public function get OrgAddition() : Vector.<Object>
      {
         return this.FOrgAddition;
      }
      
      public function set OrgAddition(param1:Vector.<Object>) : void
      {
         this.FOrgAddition = param1;
      }
      
      public function get MoneyAddition() : uint
      {
         return this.FMoneyAddition;
      }
      
      public function set MoneyAddition(param1:uint) : void
      {
         this.FMoneyAddition = param1;
      }
      
      public function get ExpAddition() : uint
      {
         return this.FExpAddition;
      }
      
      public function set ExpAddition(param1:uint) : void
      {
         this.FExpAddition = param1;
      }
      
      public function get OrgMaxMemberCount() : uint
      {
         return this.FOrgMaxMemberCount;
      }
      
      public function set OrgMaxMemberCount(param1:uint) : void
      {
         this.FOrgMaxMemberCount = param1;
      }
      
      public function get OrgCampData() : Vector.<Object>
      {
         return this.FOrgCampData;
      }
      
      public function set OrgCampData(param1:Vector.<Object>) : void
      {
         this.FOrgCampData = param1;
      }
      
      public function get OrgActivityStatus() : Vector.<Object>
      {
         return this.FOrgActivityStatus;
      }
      
      public function set OrgActivityStatus(param1:Vector.<Object>) : void
      {
         this.FOrgActivityStatus = param1;
      }
      
      public function get BasicTreasureTree() : TBasicTreasureTree
      {
         return this.FBasicTreasureTree;
      }
      
      public function set BasicTreasureTree(param1:TBasicTreasureTree) : void
      {
         this.FBasicTreasureTree = param1;
      }
      
      public function GetOrgActivityLevelByType(param1:uint) : uint
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:uint = 0;
         _loc4_ = 0;
         if(this.FOrgCampData == null)
         {
            return _loc4_;
         }
         _loc3_ = int(this.FOrgCampData.length);
         _loc2_ = 0;
         while(_loc2_ < _loc3_)
         {
            if(param1 == this.FOrgCampData[_loc2_].type)
            {
               _loc4_ = uint(this.FOrgCampData[_loc2_].level);
               break;
            }
            _loc2_++;
         }
         return _loc4_;
      }
      
      public function SetOrgActivityLevel(param1:uint, param2:uint) : void
      {
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:uint = 0;
         _loc4_ = int(this.FOrgCampData.length);
         _loc3_ = 0;
         while(_loc3_ < _loc4_)
         {
            if(param1 == this.FOrgCampData[_loc3_].type)
            {
               this.FOrgCampData[_loc3_].level = param2;
               break;
            }
            _loc3_++;
         }
      }
      
      public function GetOrgActivityStatusByType(param1:uint) : uint
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:uint = 0;
         _loc4_ = 0;
         if(!this.FOrgActivityStatus)
         {
            return _loc4_;
         }
         _loc3_ = int(this.FOrgActivityStatus.length);
         _loc2_ = 0;
         while(_loc2_ < _loc3_)
         {
            if(param1 == this.FOrgActivityStatus[_loc2_].type)
            {
               _loc4_ = uint(this.FOrgActivityStatus[_loc2_].status);
               break;
            }
            _loc2_++;
         }
         return _loc4_;
      }
   }
}

