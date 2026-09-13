package Processors.Game.Lobby.TopOrganization.Componets
{
   import Components.Standard.TUITab;
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TGameUtil;
   import Foundation.Utilities.TUtilityReflection;
   import Logics.SLogicsCore;
   import Logics.TopOrganization.TGVG3Top32Org;
   import Logics.TopOrganization.TGVG3Top32Orgs;
   import Logics.TopOrganization.TTopOrganizationData;
   import Resources.Constants.CONST_TOPORGANIZATION;
   import Resources.Strings.STRING_TOPORGANIZATION;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   
   public class TUIFinalMatchList extends TUIComponent
   {
      
      protected const CAPACITY_First_Circle:uint = 1;
      
      protected const CAPACITY_Second_Circle:uint = 2;
      
      protected const CAPACITY_Third_Circle:uint = 3;
      
      protected const CAPACITY_Forth_Circle:uint = 4;
      
      protected const CAPACITY_Fifth_Circle:uint = 5;
      
      protected const CAPACITY_Sixth_Circle:uint = 6;
      
      protected const CAPACITY_First_Circle_Lines:uint = 8;
      
      protected const CAPACITY_Second_Circle_Lines:uint = 4;
      
      protected const CAPACITY_Third_Circle_Lines:uint = 2;
      
      protected const CAPACITY_Forth_Circle_Lines:uint = 1;
      
      protected const CAPACITY_First_Circle_Bets:uint = 4;
      
      protected const CAPACITY_Second_Circle_Bets:uint = 2;
      
      protected const CAPACITY_Third_Circle_Bets:uint = 1;
      
      protected const CAPACITY_Circles:Vector.<uint> = Vector.<uint>([this.CAPACITY_First_Circle,this.CAPACITY_Second_Circle,this.CAPACITY_Third_Circle,this.CAPACITY_Forth_Circle,this.CAPACITY_Fifth_Circle,this.CAPACITY_Sixth_Circle]);
      
      protected const CAPACITY_Circle_Lines:Vector.<uint> = Vector.<uint>([this.CAPACITY_First_Circle_Lines,this.CAPACITY_Second_Circle_Lines,this.CAPACITY_Third_Circle_Lines,this.CAPACITY_Forth_Circle_Lines]);
      
      protected const CAPACITY_Circle_Bets:Vector.<uint> = Vector.<uint>([this.CAPACITY_First_Circle_Bets,this.CAPACITY_Second_Circle_Bets,this.CAPACITY_Third_Circle_Bets]);
      
      protected const CAPACITY_Both:uint = 2;
      
      protected const CAPACITY_Orgs:uint = 8;
      
      protected const CAPACITY_OrgLines:uint = 15;
      
      protected const CAPACITY_Bets:uint = 7;
      
      protected const CAPACITY_Tabs:uint = 3;
      
      protected var FMC_VSList:Sprite;
      
      protected var FMC_WinVSLose:Sprite;
      
      protected var FMC_WinCup:MovieClip;
      
      protected var FMC_LastBet:MovieClip;
      
      protected var FTF_LastBet:TextField;
      
      protected var FMC_BetWinVSLose:MovieClip;
      
      protected var FMC_OrgVec:Vector.<Sprite>;
      
      protected var FMC_OrgLineVec:Vector.<MovieClip>;
      
      protected var FMC_BetVec:Vector.<MovieClip>;
      
      protected var FTF_OrgVec:Vector.<TextField>;
      
      protected var FUITab:TUITab;
      
      protected var FTabIndex:int;
      
      protected var FGVG3Top32Orgs:TGVG3Top32Orgs;
      
      protected var FTempGVG3Top32Orgs:TGVG3Top32Orgs;
      
      protected var FTopOrganizationData:TTopOrganizationData;
      
      protected var FResetSign:Boolean;
      
      protected var FTabOnClick:Function;
      
      protected var FBetOnClick:Function;
      
      protected var FOnEffectText:Function;
      
      protected var FLookOnClick:Function;
      
      public function TUIFinalMatchList(param1:TUIComponent)
      {
         super(param1);
         this.Init();
      }
      
      protected function Init() : void
      {
         this.FMC_OrgVec = new Vector.<Sprite>();
         this.FTF_OrgVec = new Vector.<TextField>();
         this.FMC_OrgLineVec = new Vector.<MovieClip>();
         this.FMC_BetVec = new Vector.<MovieClip>();
         this.FUITab = new TUITab(this);
         this.FTempGVG3Top32Orgs = new TGVG3Top32Orgs();
         this.FTopOrganizationData = SLogicsCore.TopOrganizationData;
         this.FGVG3Top32Orgs = this.FTopOrganizationData.GVG3Top32Orgs;
         this.FResetSign = false;
      }
      
      protected function ResourcesPerform_UIDispatch() : void
      {
         var _loc1_:int = 0;
         var _loc2_:uint = 0;
         var _loc3_:MovieClip = null;
         var _loc4_:MovieClip = null;
         var _loc5_:Sprite = null;
         var _loc6_:int = 0;
         var _loc7_:uint = 0;
         var _loc8_:int = 0;
         var _loc9_:uint = 0;
         var _loc10_:Sprite = null;
         var _loc11_:int = 0;
         var _loc12_:TextField = null;
         _loc8_ = 0;
         _loc11_ = 0;
         _loc10_ = TUtilityReflection.CreateDisplayObjectInstance(CONST_TOPORGANIZATION.RESOURCE_ClassName_MC_UIFinalMatchList) as Sprite;
         addChild(_loc10_);
         this.FMC_VSList = _loc10_["MC_VSList"];
         this.FMC_WinCup = this.FMC_VSList["MC_WinCup"];
         this.FMC_WinCup.gotoAndStop(1);
         this.FMC_WinVSLose = _loc10_["MC_WinVSLose"];
         this.FMC_WinVSLose.visible = false;
         this.FMC_WinVSLose["MC_WinCup"].gotoAndStop(3);
         this.FMC_BetWinVSLose = this.FMC_WinVSLose["MC_BetWinVSLose"];
         TGameUtil.setButtonMode(this.FMC_BetWinVSLose,true);
         this.FMC_LastBet = this.FMC_VSList["MC_Bet_2_4_0"];
         this.FTF_LastBet = this.FMC_LastBet["TF_Last"];
         TGameUtil.setButtonMode(this.FMC_LastBet,true);
         this.FMC_LastBet.visible = false;
         _loc2_ = this.CAPACITY_Tabs;
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            _loc3_ = _loc10_["MC_Tab_" + _loc1_];
            this.FUITab.SetTabByIndex(_loc3_,_loc1_);
            _loc1_++;
         }
         this.FUITab.OnSwitch = this.TabOnSwitch;
         this.FUITab.Init();
         _loc11_ = 0;
         _loc7_ = this.CAPACITY_Both;
         _loc6_ = 0;
         while(_loc6_ < _loc7_)
         {
            _loc9_ = this.CAPACITY_Orgs;
            _loc8_ = 0;
            while(_loc8_ < _loc9_)
            {
               _loc5_ = this.FMC_VSList["MC_Org_" + _loc6_ + "_" + _loc8_];
               this.FMC_OrgVec[_loc11_] = _loc5_;
               _loc12_ = _loc5_["TF_OrgName"];
               this.FTF_OrgVec[_loc11_] = _loc12_;
               _loc11_++;
               _loc8_++;
            }
            _loc6_++;
         }
         _loc11_ = 0;
         _loc2_ = this.CAPACITY_Both;
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            _loc7_ = this.CAPACITY_Circles.length;
            _loc6_ = 0;
            while(_loc6_ < _loc7_)
            {
               if(_loc6_ < this.CAPACITY_Circle_Bets.length)
               {
                  _loc9_ = this.CAPACITY_Circle_Bets[_loc6_];
                  _loc8_ = 0;
                  while(_loc8_ < _loc9_)
                  {
                     _loc4_ = this.FMC_VSList["MC_Bet_" + _loc1_ + "_" + this.CAPACITY_Circles[_loc6_] + "_" + _loc8_];
                     _loc4_.visible = false;
                     this.FMC_BetVec[_loc11_] = _loc4_;
                     _loc11_++;
                     _loc8_++;
                  }
               }
               _loc6_++;
            }
            _loc1_++;
         }
         _loc11_ = 0;
         _loc2_ = this.CAPACITY_Both;
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            _loc7_ = this.CAPACITY_Circles.length;
            _loc6_ = 0;
            while(_loc6_ < _loc7_)
            {
               if(_loc6_ < this.CAPACITY_Circle_Lines.length)
               {
                  _loc9_ = this.CAPACITY_Circle_Lines[_loc6_];
                  _loc8_ = 0;
                  while(_loc8_ < _loc9_)
                  {
                     _loc4_ = this.FMC_VSList["MC_OrgLine_" + _loc1_ + "_" + this.CAPACITY_Circles[_loc6_] + "_" + _loc8_];
                     this.FMC_OrgLineVec[_loc11_] = _loc4_;
                     _loc11_++;
                     _loc8_++;
                  }
               }
               _loc6_++;
            }
            _loc1_++;
         }
      }
      
      protected function ResourcesPerform_UILocations() : void
      {
         this.FMC_LastBet.addEventListener(MouseEvent.CLICK,this.MCBetOnClick,false,0,true);
         this.FMC_BetWinVSLose.addEventListener(MouseEvent.CLICK,this.MCBetOnClick,false,0,true);
      }
      
      protected function UpdateOrgLines() : void
      {
         var _loc1_:int = 0;
         var _loc2_:uint = 0;
         var _loc3_:MovieClip = null;
         var _loc4_:Array = null;
         var _loc5_:uint = 0;
         var _loc6_:int = 0;
         var _loc7_:uint = 0;
         _loc2_ = this.FMC_OrgLineVec.length;
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            _loc3_ = this.FMC_OrgLineVec[_loc1_];
            _loc4_ = _loc3_.name.split("_");
            _loc7_ = parseInt(_loc4_[2]);
            _loc5_ = parseInt(_loc4_[3]);
            _loc6_ = parseInt(_loc4_[4]);
            _loc3_.gotoAndStop(uint(this.CheckLines(_loc7_,_loc5_,_loc6_)) + 1);
            _loc1_++;
         }
      }
      
      protected function CheckLines(param1:uint, param2:uint, param3:int) : Boolean
      {
         var _loc4_:int = 0;
         var _loc5_:uint = 0;
         var _loc6_:Sprite = null;
         var _loc7_:String = null;
         var _loc8_:Array = null;
         var _loc9_:uint = 0;
         var _loc10_:int = 0;
         var _loc11_:uint = 0;
         var _loc12_:TGVG3Top32Org = null;
         var _loc13_:int = 0;
         var _loc14_:uint = 0;
         var _loc15_:int = 0;
         var _loc16_:int = 0;
         _loc11_ = this.FTopOrganizationData.CurrentRound;
         if(_loc11_ < param2)
         {
            return true;
         }
         _loc13_ = Math.pow(2,param2 - 1) * param3 + this.CAPACITY_Orgs * param1;
         _loc15_ = Math.pow(2,param2 - 1) * (param3 + 1) + this.CAPACITY_Orgs * param1;
         _loc16_ = _loc13_;
         while(_loc16_ < _loc15_)
         {
            _loc12_ = this.FGVG3Top32Orgs.GetGVG3Top32OrgByIndex(_loc16_);
            if(_loc12_ == null)
            {
               return true;
            }
            if(_loc12_.LoseCircle == param2)
            {
               return true;
            }
            if(_loc12_.LoseCircle > param2)
            {
               return false;
            }
            if(_loc12_.LoseCircle == 0)
            {
               return false;
            }
            _loc16_++;
         }
         return false;
      }
      
      protected function UpdateBetButton() : void
      {
         var _loc1_:int = 0;
         var _loc2_:uint = 0;
         var _loc3_:MovieClip = null;
         var _loc4_:uint = 0;
         var _loc5_:int = 0;
         var _loc6_:Array = null;
         var _loc7_:String = null;
         var _loc8_:uint = 0;
         var _loc9_:uint = 0;
         var _loc10_:uint = 0;
         var _loc11_:uint = 0;
         _loc7_ = "";
         _loc8_ = this.FTopOrganizationData.CurrentRound;
         _loc9_ = this.FTopOrganizationData.CurrentBetCircle;
         this.FMC_LastBet.visible = _loc8_ == this.CAPACITY_Forth_Circle || _loc8_ == this.CAPACITY_Fifth_Circle;
         _loc11_ = this.CheckTOP32Org();
         if(_loc11_ == this.CAPACITY_Fifth_Circle || _loc11_ == this.CAPACITY_Forth_Circle)
         {
            _loc7_ = STRING_TOPORGANIZATION.STRING_BetStatus[2];
         }
         else if(_loc9_ == 0)
         {
            _loc7_ = STRING_TOPORGANIZATION.STRING_BetStatus[0];
         }
         else if(_loc9_ != 0)
         {
            _loc7_ = STRING_TOPORGANIZATION.STRING_BetStatus[1];
         }
         this.FTF_LastBet.text = _loc7_;
         _loc2_ = this.FMC_BetVec.length;
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            _loc3_ = this.FMC_BetVec[_loc1_];
            _loc6_ = _loc3_.name.split("_");
            _loc10_ = parseInt(_loc6_[2]);
            _loc4_ = parseInt(_loc6_[3]);
            _loc5_ = parseInt(_loc6_[4]);
            _loc3_.visible = this.CheckBetVisible(_loc10_,_loc4_,_loc5_);
            _loc3_ = this.FMC_BetVec[_loc1_];
            _loc7_ = this.CheckBetButtonCurrentFrame(_loc10_,_loc4_,_loc5_);
            if(_loc7_ != "")
            {
               _loc3_.gotoAndStop(_loc7_);
               _loc3_ = _loc3_["MC_" + _loc7_];
               TGameUtil.setButtonMode(_loc3_,true);
               if(!_loc3_.hasEventListener(MouseEvent.CLICK))
               {
                  _loc3_.addEventListener(MouseEvent.CLICK,this.MCBetOnClick,false,0,true);
               }
            }
            _loc1_++;
         }
      }
      
      protected function CheckBetButtonCurrentFrame(param1:uint, param2:uint, param3:int) : String
      {
         var _loc4_:int = 0;
         var _loc5_:uint = 0;
         var _loc6_:uint = 0;
         var _loc7_:Sprite = null;
         var _loc8_:Array = null;
         var _loc9_:uint = 0;
         var _loc10_:uint = 0;
         var _loc11_:TGVG3Top32Org = null;
         var _loc12_:int = 0;
         var _loc13_:int = 0;
         var _loc14_:int = 0;
         var _loc15_:int = 0;
         var _loc16_:Vector.<Boolean> = null;
         var _loc17_:String = null;
         var _loc18_:uint = 0;
         _loc6_ = this.FTopOrganizationData.CurrentRound;
         _loc10_ = this.FTopOrganizationData.CurrentBetCircle;
         _loc16_ = new Vector.<Boolean>();
         _loc18_ = this.CheckTOP32Org();
         if(_loc6_ == _loc18_)
         {
            return "Lookup";
         }
         if(_loc10_ == 0)
         {
            if(_loc6_ == param2)
            {
               return "NotBet";
            }
         }
         else
         {
            _loc12_ = this.FGVG3Top32Orgs.GetIndexByIndentifier(this.FTopOrganizationData.CurrentBetAttOrgID);
            _loc13_ = this.FGVG3Top32Orgs.GetIndexByIndentifier(this.FTopOrganizationData.CurrentBetDefOrgID);
            if(_loc12_ != -1 && _loc13_ != -1)
            {
               _loc14_ = Math.pow(2,param2) * param3 + this.CAPACITY_Orgs * param1;
               _loc15_ = Math.pow(2,param2) * (param3 + 1) + this.CAPACITY_Orgs * param1;
               _loc4_ = _loc14_;
               while(_loc4_ < _loc15_)
               {
                  if(_loc4_ == _loc12_ || _loc4_ == _loc13_)
                  {
                     _loc16_.push(true);
                  }
                  _loc4_++;
               }
               if(_loc16_.length >= 2)
               {
                  if(_loc16_[0] && _loc16_[1])
                  {
                     return "HasBet";
                  }
               }
            }
         }
         return "";
      }
      
      protected function CheckTOP32Org() : uint
      {
         var _loc1_:int = 0;
         var _loc2_:uint = 0;
         var _loc3_:Vector.<uint> = null;
         var _loc4_:uint = 0;
         var _loc5_:TGVG3Top32Orgs = null;
         var _loc6_:TGVG3Top32Org = null;
         var _loc7_:int = 0;
         var _loc8_:Array = null;
         _loc8_ = new Array();
         _loc2_ = this.FGVG3Top32Orgs.Count;
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            _loc6_ = this.FGVG3Top32Orgs.GetGVG3Top32OrgByIndex(_loc1_);
            _loc4_ = _loc6_.LoseCircle;
            _loc7_ = _loc8_.indexOf(_loc4_);
            if(_loc7_ == -1)
            {
               _loc8_.push(_loc4_);
            }
            _loc1_++;
         }
         _loc8_.sort(Array.NUMERIC | Array.DESCENDING);
         return _loc8_[0];
      }
      
      protected function CheckBetVisible(param1:uint, param2:uint, param3:int) : Boolean
      {
         var _loc4_:int = 0;
         var _loc5_:uint = 0;
         var _loc6_:Sprite = null;
         var _loc7_:String = null;
         var _loc8_:Array = null;
         var _loc9_:uint = 0;
         var _loc10_:int = 0;
         var _loc11_:uint = 0;
         var _loc12_:uint = 0;
         var _loc13_:TGVG3Top32Org = null;
         var _loc14_:int = 0;
         var _loc15_:int = 0;
         var _loc16_:int = 0;
         var _loc17_:Vector.<TGVG3Top32Org> = null;
         var _loc18_:int = 0;
         var _loc19_:uint = 0;
         _loc11_ = this.FTopOrganizationData.CurrentRound;
         _loc12_ = this.FTopOrganizationData.CurrentBetCircle;
         _loc17_ = new Vector.<TGVG3Top32Org>();
         _loc5_ = this.FGVG3Top32Orgs.Count;
         _loc19_ = this.CheckTOP32Org();
         if(_loc11_ == param2)
         {
            return true;
         }
         if(_loc5_ == 1)
         {
            return false;
         }
         _loc14_ = Math.pow(2,param2) * (param3 + 1) + param1 * this.CAPACITY_Orgs;
         _loc15_ = _loc16_ = Math.pow(2,param2) * param3 + param1 * this.CAPACITY_Orgs;
         while(_loc15_ < _loc14_)
         {
            _loc13_ = this.FGVG3Top32Orgs.GetGVG3Top32OrgByIndex(_loc15_);
            if(_loc13_ != null && _loc11_ == param2 + 1 && _loc13_.LoseCircle == param2)
            {
               _loc17_.push(_loc13_);
            }
            _loc15_++;
         }
         if(_loc17_.length == 2)
         {
            return true;
         }
         return false;
      }
      
      protected function UpdateOrgs() : void
      {
         var _loc1_:int = 0;
         var _loc2_:uint = 0;
         var _loc3_:TGVG3Top32Org = null;
         var _loc4_:TextField = null;
         _loc2_ = this.FMC_OrgVec.length;
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            _loc4_ = this.FTF_OrgVec[_loc1_];
            _loc4_.text = "";
            _loc1_++;
         }
         _loc2_ = this.FTF_OrgVec.length;
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            _loc4_ = this.FTF_OrgVec[_loc1_];
            _loc3_ = this.FGVG3Top32Orgs.GetGVG3Top32OrgByIndex(_loc1_);
            if(_loc3_ != null && _loc1_ == _loc3_.InitPos)
            {
               _loc4_.text = _loc3_.OrgName;
            }
            _loc1_++;
         }
      }
      
      protected function CheckFightBoth(param1:uint, param2:uint, param3:int) : TGVG3Top32Orgs
      {
         var _loc4_:int = 0;
         var _loc5_:uint = 0;
         var _loc6_:TGVG3Top32Org = null;
         var _loc7_:int = 0;
         var _loc8_:Sprite = null;
         var _loc9_:int = 0;
         var _loc10_:int = 0;
         var _loc11_:uint = 0;
         var _loc12_:String = null;
         var _loc13_:Array = null;
         var _loc14_:uint = 0;
         var _loc15_:int = 0;
         var _loc16_:int = 0;
         _loc11_ = this.FTopOrganizationData.CurrentRound;
         _loc5_ = this.FGVG3Top32Orgs.Count;
         this.FTempGVG3Top32Orgs.Clear();
         if(param2 == this.CAPACITY_Forth_Circle)
         {
            _loc4_ = 0;
            while(_loc4_ < _loc5_)
            {
               _loc6_ = this.FGVG3Top32Orgs.GetGVG3Top32OrgByIndex(_loc4_);
               if(_loc6_ != null && (_loc6_.LoseCircle == 0 || _loc6_.LoseCircle >= param2))
               {
                  this.FTempGVG3Top32Orgs.Add(_loc6_);
               }
               _loc4_++;
            }
         }
         else
         {
            _loc7_ = Math.pow(2,param2) * (param3 + 1) + param1 * this.CAPACITY_Orgs;
            _loc9_ = _loc10_ = Math.pow(2,param2) * param3 + param1 * this.CAPACITY_Orgs;
            while(_loc9_ < _loc7_)
            {
               _loc6_ = this.FGVG3Top32Orgs.GetGVG3Top32OrgByIndex(_loc9_);
               if(_loc6_ != null && (_loc6_.LoseCircle == 0 || _loc6_.LoseCircle >= param2))
               {
                  this.FTempGVG3Top32Orgs.Add(_loc6_);
               }
               _loc9_++;
            }
         }
         return this.FTempGVG3Top32Orgs;
      }
      
      protected function UpdateUI() : void
      {
         this.UpdateOrgs();
         this.UpdateOrgLines();
         this.UpdateBetButton();
      }
      
      protected function UpdateWinVSLoseUI() : void
      {
         var _loc1_:Vector.<Boolean> = null;
         var _loc2_:int = 0;
         var _loc3_:uint = 0;
         var _loc4_:TGVG3Top32Org = null;
         var _loc5_:Boolean = false;
         var _loc6_:uint = 0;
         var _loc7_:String = null;
         var _loc8_:uint = 0;
         var _loc9_:uint = 0;
         var _loc10_:uint = 0;
         _loc7_ = "";
         _loc8_ = this.FTopOrganizationData.CurrentRound;
         _loc9_ = this.FTopOrganizationData.CurrentBetCircle;
         _loc1_ = new Vector.<Boolean>();
         _loc3_ = this.FGVG3Top32Orgs.Count;
         _loc2_ = 0;
         while(_loc2_ < _loc3_)
         {
            _loc4_ = this.FGVG3Top32Orgs.GetGVG3Top32OrgByIndex(_loc2_);
            if(_loc2_ < 2)
            {
               _loc5_ = true;
               if(_loc4_.OrgID != 0)
               {
                  this.FMC_WinVSLose["MC_Org_" + _loc2_]["TF_OrgName"].text = _loc4_.OrgName;
                  _loc5_ = _loc4_.LoseCircle == this.CAPACITY_Fifth_Circle;
               }
               else
               {
                  this.FMC_WinVSLose["MC_Org_" + _loc2_]["TF_OrgName"].text = "";
               }
               _loc1_.push(_loc5_);
            }
            _loc2_++;
         }
         this.FMC_BetWinVSLose.visible = _loc1_.length > 1;
         _loc3_ = 2;
         _loc2_ = 0;
         while(_loc2_ < _loc3_)
         {
            this.FMC_WinVSLose["MC_Line_" + _loc2_].gotoAndStop(2);
            _loc2_++;
         }
         _loc3_ = _loc1_.length;
         _loc2_ = 0;
         while(_loc2_ < _loc3_)
         {
            _loc5_ = _loc1_[_loc2_];
            _loc6_ = uint(_loc5_) + 1;
            this.FMC_WinVSLose["MC_Line_" + _loc2_].gotoAndStop(_loc6_);
            _loc2_++;
         }
         this.FMC_VSList.visible = false;
         this.FMC_WinVSLose.visible = _loc3_ > 0;
         _loc10_ = this.CheckTOP32Org();
         if(_loc10_ == this.CAPACITY_Fifth_Circle || _loc10_ == this.CAPACITY_Forth_Circle)
         {
            _loc7_ = STRING_TOPORGANIZATION.STRING_BetStatus[2];
         }
         else if(_loc9_ == 0)
         {
            _loc7_ = STRING_TOPORGANIZATION.STRING_BetStatus[0];
         }
         else if(_loc9_ != 0)
         {
            _loc7_ = STRING_TOPORGANIZATION.STRING_BetStatus[1];
         }
         this.FMC_BetWinVSLose["TF_Last"].text = _loc7_;
      }
      
      protected function ResetUI() : void
      {
         var _loc1_:int = 0;
         var _loc2_:uint = 0;
         var _loc3_:MovieClip = null;
         var _loc4_:TextField = null;
         _loc2_ = this.FMC_OrgLineVec.length;
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            _loc3_ = this.FMC_OrgLineVec[_loc1_];
            _loc3_.gotoAndStop(2);
            _loc1_++;
         }
         _loc2_ = this.FMC_BetVec.length;
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            _loc3_ = this.FMC_BetVec[_loc1_];
            _loc3_.visible = false;
            _loc1_++;
         }
         _loc2_ = this.FMC_OrgVec.length;
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            _loc4_ = this.FTF_OrgVec[_loc1_];
            _loc4_.text = "";
            _loc1_++;
         }
         this.FMC_VSList.visible = false;
         this.FMC_WinVSLose.visible = false;
      }
      
      protected function MCBetOnClick(param1:MouseEvent) : void
      {
         var _loc2_:MovieClip = null;
         var _loc3_:String = null;
         var _loc4_:Array = null;
         var _loc5_:uint = 0;
         var _loc6_:uint = 0;
         var _loc7_:int = 0;
         var _loc8_:int = 0;
         var _loc9_:TGVG3Top32Org = null;
         var _loc10_:TGVG3Top32Org = null;
         var _loc11_:TGVG3Top32Orgs = null;
         var _loc12_:uint = 0;
         var _loc13_:uint = 0;
         _loc2_ = param1.currentTarget as MovieClip;
         _loc3_ = _loc2_.name;
         _loc13_ = this.FTopOrganizationData.CurrentRound;
         if(_loc3_ == "MC_BetWinVSLose")
         {
            _loc11_ = this.FGVG3Top32Orgs;
            _loc9_ = this.FGVG3Top32Orgs.GetGVG3Top32OrgByIndex(0);
            _loc10_ = this.FGVG3Top32Orgs.GetGVG3Top32OrgByIndex(1);
            if(_loc13_ == this.CAPACITY_Fifth_Circle)
            {
               _loc8_ = STRING_TOPORGANIZATION.STRING_BetStatus.indexOf(this.FMC_BetWinVSLose["TF_Last"].text);
            }
         }
         else if(_loc3_ != "MC_Bet_2_4_0")
         {
            _loc2_ = param1.currentTarget.parent as MovieClip;
            _loc3_ = _loc2_.name;
         }
         if(_loc3_ != "MC_BetWinVSLose")
         {
            _loc4_ = _loc3_.split("_");
            _loc5_ = uint(_loc4_[2]);
            _loc6_ = uint(_loc4_[3]);
            _loc7_ = int(_loc4_[4]);
            _loc11_ = this.CheckFightBoth(_loc5_,_loc6_,_loc7_);
            if(_loc13_ == this.CAPACITY_Fifth_Circle || _loc13_ == this.CAPACITY_Forth_Circle)
            {
               _loc8_ = STRING_TOPORGANIZATION.STRING_BetStatus.indexOf(this.FTF_LastBet.text);
            }
            _loc9_ = _loc11_.GetGVG3Top32OrgByIndex(0);
            _loc10_ = _loc11_.GetGVG3Top32OrgByIndex(1);
         }
         if(_loc11_.Count < 2)
         {
            if(this.FOnEffectText != null)
            {
               this.FOnEffectText(STRING_TOPORGANIZATION.STRING_OnlyOneOrg);
            }
            return;
         }
         if(_loc2_.currentFrameLabel == "Lookup" || _loc8_ == 2)
         {
            if(this.FLookOnClick != null)
            {
               this.FLookOnClick(this,_loc9_,_loc10_);
            }
         }
         else if(this.FBetOnClick != null)
         {
            this.FBetOnClick(this,_loc9_,_loc10_);
         }
      }
      
      protected function TabOnSwitch(param1:Object) : void
      {
         if(param1 is int)
         {
            this.FTabIndex = param1 as int;
         }
         this.ResetUI();
         if(this.FTabIndex != 2)
         {
            this.FMC_WinCup.gotoAndStop(this.FTabIndex + 1);
            this.FMC_VSList.visible = true;
            this.FMC_WinVSLose.visible = false;
            this.FMC_LastBet.visible = false;
         }
         if(this.FResetSign)
         {
            this.FResetSign = false;
            return;
         }
         if(this.FTabOnClick != null)
         {
            this.FTabOnClick(this,this.FTabIndex);
         }
      }
      
      public function set TabOnClick(param1:Function) : void
      {
         this.FTabOnClick = param1;
      }
      
      public function set BetOnClick(param1:Function) : void
      {
         this.FBetOnClick = param1;
      }
      
      public function set OnEffectText(param1:Function) : void
      {
         this.FOnEffectText = param1;
      }
      
      public function set LookOnClick(param1:Function) : void
      {
         this.FLookOnClick = param1;
      }
      
      public function Update() : void
      {
         if(this.FGVG3Top32Orgs == null)
         {
            return;
         }
         if(this.FTabIndex != CONST_TOPORGANIZATION.GROUPTYPE_Total)
         {
            this.UpdateUI();
            this.FMC_VSList.visible = true;
            this.FMC_WinVSLose.visible = false;
         }
         else
         {
            this.UpdateWinVSLoseUI();
         }
      }
      
      public function UIDispatch() : void
      {
         this.ResourcesPerform_UIDispatch();
      }
      
      public function UILocations() : void
      {
         this.ResourcesPerform_UILocations();
      }
      
      public function HideBetButton() : void
      {
         var _loc1_:int = 0;
         var _loc2_:uint = 0;
         var _loc3_:MovieClip = null;
         _loc2_ = this.FMC_BetVec.length;
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            _loc3_ = this.FMC_BetVec[_loc1_];
            _loc3_.visible = false;
            _loc1_++;
         }
         this.FMC_LastBet.visible = false;
         this.FMC_BetWinVSLose.visible = false;
      }
      
      public function UpdateBetButtonUI() : void
      {
         if(this.FTopOrganizationData.GroupType != 2)
         {
            this.UpdateBetButton();
         }
         else
         {
            this.UpdateWinVSLoseUI();
         }
      }
      
      public function UpdateNotify() : void
      {
         if(this.FTabIndex != this.FTopOrganizationData.GroupType)
         {
            this.FTabIndex = this.FTopOrganizationData.GroupType;
            this.FUITab.SwithTagManual(this.FTabIndex);
         }
         else
         {
            this.Update();
         }
      }
      
      public function Reset() : void
      {
         this.FResetSign = true;
         this.ResetUI();
         this.FTabIndex = 0;
         this.FUITab.SwithTagManual(0);
      }
   }
}

