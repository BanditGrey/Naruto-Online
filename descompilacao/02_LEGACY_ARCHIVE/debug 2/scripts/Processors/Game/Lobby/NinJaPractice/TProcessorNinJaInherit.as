package Processors.Game.Lobby.NinJaPractice
{
   import Foundation.Network.SNetworkCore;
   import Foundation.Network.TPacket;
   import Foundation.Resources.SResourcesCore;
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TGameUtil;
   import Foundation.Utilities.TUtilityReflection;
   import Foundation.Utilities.TUtilityString;
   import Logics.Characters.THero;
   import Logics.Characters.THeros;
   import Logics.DatebaseVO.VO.TConfigValue;
   import Logics.DatebaseVO.VO.TNinJaPractice;
   import Logics.SLogicsCore;
   import Processors.Game.Lobby.Common.TLobbyParameters;
   import Processors.Game.Lobby.Common.TProcessorLobbyWindows;
   import Processors.Game.Lobby.TreasureMap.ConsumeFrame;
   import Processors.Game.Windows.Information.TUIWindowConfirmation;
   import Resources.Constants.CONST_COMMON;
   import Resources.Constants.CONST_CONFIGVALUE;
   import Resources.Constants.CONST_DATEBASEVO;
   import Resources.Constants.CONST_NETWORK;
   import Resources.Constants.CONST_NINJAPRACTICE;
   import Resources.Constants.CONST_SYSTEMLANGUAGE;
   import Resources.Strings.STRING_INHERITPRACTICE;
   import Utilities.UI.Windows.TUtilityUIWindow;
   import flash.display.MovieClip;
   import flash.display.SimpleButton;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import flash.utils.ByteArray;
   
   public class TProcessorNinJaInherit extends TProcessorLobbyWindows
   {
      
      public static const JINJA_MVC_COUNT:int = 6;
      
      protected var FMC_Inherit:MovieClip;
      
      protected var MVCselect:MovieClip;
      
      protected var heros:THeros;
      
      protected var cur_page_index:int = 1;
      
      protected var all_page_index:int = 1;
      
      protected var index_one:int = 0;
      
      protected var index_two:int = 0;
      
      protected var vec_Uint01:Vector.<JinJaPracticeUint>;
      
      protected var vec_Uint02:Vector.<JinJaPracticeUint>;
      
      protected var id_arr:Array;
      
      protected var inherit_type:uint = 1;
      
      protected var mony_unit:Vector.<Object>;
      
      private var FUIWindowConfirmation:TUIWindowConfirmation;
      
      protected var FPopWindow:TUIWindowConfirmation;
      
      protected var _cur_rate:Number;
      
      protected var FUpdateHeroPower:Function;
      
      protected var FNewPotentiaLv:String;
      
      protected var _open_close:Boolean = false;
      
      protected var _bLostExp:Boolean;
      
      protected var MaxLevelForQianNeng:int = 0;
      
      protected var MaxLevelForQianNengdatA:TNinJaPractice = null;
      
      protected var tempQianNengdatA:TNinJaPractice = null;
      
      protected var Fonose:Function;
      
      public function TProcessorNinJaInherit(param1:TUIComponent, param2:TLobbyParameters)
      {
         super(param1,param2);
         var _loc3_:JinJaPracticeUint = new JinJaPracticeUint();
         _loc3_.initin(null,null,0);
         var _loc4_:JinJaPracticeUint = new JinJaPracticeUint();
         _loc4_.initin(null,null,0);
         this.vec_Uint01 = new Vector.<JinJaPracticeUint>();
         this.vec_Uint02 = new Vector.<JinJaPracticeUint>(2);
         this.vec_Uint02[0] = _loc3_;
         this.vec_Uint02[1] = _loc4_;
         this.id_arr = new Array(2);
         this.id_arr[0] = 0;
         this.id_arr[1] = 0;
      }
      
      override protected function ResourcesPerform_UIRequest() : void
      {
         SResourcesCore.TexturesSwfLobby.LoadPrimary(CONST_NINJAPRACTICE.JinNaPractice_RootId);
         super.ResourcesPerform_UIRequest();
      }
      
      override protected function ResourcesPerform_UIDispatch() : void
      {
         this.FMC_Inherit = TUtilityReflection.CreateDisplayObjectInstance(CONST_NINJAPRACTICE.JinNa_RootName) as MovieClip;
         addChild(this.FMC_Inherit);
         this.FMC_Inherit.x = CONST_COMMON.STAGE_Width - this.FMC_Inherit.width >> 1;
         this.FMC_Inherit.y = CONST_COMMON.STAGE_Height - this.FMC_Inherit.height >> 1;
         this.FUIWindowConfirmation = new TUIWindowConfirmation(this);
         this.FUIWindowConfirmation.OnOK = this.ConfirmOnOk;
         TUtilityUIWindow.SetupWindowConfirmation(this.FUIWindowConfirmation);
         this.FUIWindowConfirmation.x = (CONST_COMMON.STAGE_Width - this.FUIWindowConfirmation.WindowWidth) / 2;
         this.FUIWindowConfirmation.y = (CONST_COMMON.STAGE_Height - this.FUIWindowConfirmation.WindowHeight) / 2 - 20;
         this.FUIWindowConfirmation.SetCheckBox(false);
         this.FPopWindow = new TUIWindowConfirmation(this);
         this.FPopWindow.OnOK = this.PopWindowOnOk;
         this.FPopWindow.x = CONST_COMMON.STAGE_Width - this.FPopWindow.WindowWidth >> 1;
         this.FPopWindow.y = CONST_COMMON.STAGE_Height - this.FPopWindow.WindowHeight >> 1;
         TUtilityUIWindow.SetupWindowConfirmation(this.FPopWindow);
         this.FPopWindow.visible = false;
         super.ResourcesPerform_UIDispatch();
      }
      
      override protected function ResourcesPerform_UILocations() : void
      {
         var _loc1_:TConfigValue = null;
         var _loc2_:Vector.<Object> = null;
         _loc1_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_ConfigValue,CONST_CONFIGVALUE.NinjaUpgrade_ExchangePercent) as TConfigValue;
         this.mony_unit = _loc1_.Value as Vector.<Object>;
         this.initValue();
         this.addEvent();
         this.clear_inherit();
         this.clear_inherit_M();
         super.ResourcesPerform_UILocations();
      }
      
      public function openMe() : void
      {
         this.initValue();
      }
      
      protected function initValue() : void
      {
         var _loc2_:JinJaPracticeUint = null;
         var _loc9_:THero = null;
         var _loc10_:int = 0;
         var _loc11_:THero = null;
         this.clear_one_two();
         this.heros = SLogicsCore.Character.Heros;
         var _loc1_:Number = Number(this.heros.Count);
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:int = 100;
         var _loc7_:int = 100;
         var _loc8_:int = 0;
         _loc4_ = 0;
         while(_loc4_ < _loc1_)
         {
            _loc9_ = this.heros.GetHeroByIndex(_loc4_);
            if(_loc9_.Identifier == this.id_arr[0])
            {
               _loc6_ = _loc4_;
            }
            else if(_loc9_.Identifier == this.id_arr[1])
            {
               _loc7_ = _loc4_;
            }
            _loc4_++;
         }
         _loc4_ = 0;
         while(_loc4_ < JINJA_MVC_COUNT + _loc5_)
         {
            _loc10_ = _loc4_ + (this.cur_page_index - 1) * JINJA_MVC_COUNT;
            if(this._open_close)
            {
               _loc8_ = 0;
               if(_loc10_ >= _loc6_ && _loc6_ != 100)
               {
                  _loc8_ += 1;
               }
               if(_loc10_ >= _loc7_ && _loc7_ != 100)
               {
                  _loc8_ += 1;
               }
               _loc10_ += _loc8_;
            }
            if(_loc10_ >= _loc1_)
            {
               if(_loc3_ <= 5)
               {
                  MovieClip(this.FMC_Inherit["MC_Hero_" + _loc3_]).visible = false;
                  _loc3_++;
               }
            }
            else
            {
               _loc11_ = this.heros.GetHeroByIndex(_loc10_);
               if(_loc11_.Identifier != this.id_arr[0] && _loc11_.Identifier != this.id_arr[1])
               {
                  if(_loc3_ < this.vec_Uint01.length)
                  {
                     _loc2_ = this.vec_Uint01[_loc3_];
                  }
                  else
                  {
                     _loc2_ = new JinJaPracticeUint();
                  }
                  _loc2_.initin(MovieClip(this.FMC_Inherit["MC_Hero_" + _loc3_]),_loc11_,0);
                  _loc2_.fction = this.selec_click;
                  this.vec_Uint01[_loc3_] = _loc2_;
                  MovieClip(this.FMC_Inherit["MC_Hero_" + _loc3_]).visible = true;
                  _loc3_++;
               }
               else
               {
                  _loc5_ += 1;
               }
            }
            _loc4_++;
         }
         this.initValue_right();
         this.repre();
      }
      
      protected function handlerHero_one(param1:THero) : void
      {
         TextField(this.FMC_Inherit["TF_Name_10"]).text = "+" + param1.GetQianNengOnlyLevelStr(param1.PotentialLv);
         TextField(this.FMC_Inherit["TF_Name_11"]).text = "+0";
      }
      
      protected function GetLogicsLevel(param1:uint) : uint
      {
         var _loc2_:uint = 0;
         if(param1 > CONST_COMMON.Ninja_Three_QianNeng)
         {
            _loc2_ = CONST_COMMON.Ninja_Three_Reincarnation_Footstone + param1 - CONST_COMMON.Ninja_Three_QianNeng;
         }
         else if(param1 > CONST_COMMON.Ninja_Two_QianNeng)
         {
            _loc2_ = CONST_COMMON.Ninja_Two_Reincarnation_Footstone + param1 - CONST_COMMON.Ninja_Two_QianNeng;
         }
         else if(param1 > CONST_COMMON.Ninja_One_QianNeng)
         {
            _loc2_ = CONST_COMMON.Ninja_One_Reincarnation_Footstone + param1 - CONST_COMMON.Ninja_One_QianNeng;
         }
         else
         {
            _loc2_ = param1;
         }
         return _loc2_;
      }
      
      protected function handlerHero_two(param1:THero, param2:THero) : void
      {
         var _loc3_:int = 0;
         var _loc6_:int = 0;
         if(this.id_arr[1] == 0 || this.id_arr[0] == 0)
         {
            TextField(this.FMC_Inherit["TF_Name_20"]).text = "+0";
            TextField(this.FMC_Inherit["TF_Name21"]).text = "+0";
            return;
         }
         var _loc4_:uint = uint((this.get_hero_exp(param1.PotentialLv + 1) + param1.PotentialExp) * this._cur_rate) + param2.PotentialExp;
         var _loc5_:uint = param2.PotentialLv;
         this.MaxLevelForQianNeng = param2.Level;
         this.getLevelNum();
         this._bLostExp = false;
         while(true)
         {
            _loc6_ = this.get_hero_exp_next(_loc5_ + 1);
            if(_loc6_ >= _loc4_)
            {
               break;
            }
            if(_loc5_ >= CONST_COMMON.Ninja_Max_QianNeng)
            {
               _loc5_ = uint(CONST_COMMON.Ninja_Max_QianNeng);
               if(_loc4_ > 0)
               {
                  this._bLostExp = true;
               }
               break;
            }
            _loc5_++;
            _loc4_ -= _loc6_;
            if(this.GetLogicsLevel(_loc5_) > param2.Level)
            {
               _loc5_--;
               if(_loc4_ > 0)
               {
                  this._bLostExp = true;
               }
               break;
            }
         }
         switch(param2.ReincarnationOneOrTwo)
         {
            case 0:
               if(_loc5_ > CONST_COMMON.Ninja_One_QianNeng)
               {
                  _loc5_ = uint(CONST_COMMON.Ninja_One_QianNeng);
               }
               break;
            case 1:
               if(_loc5_ > CONST_COMMON.Ninja_Two_QianNeng)
               {
                  _loc5_ = uint(CONST_COMMON.Ninja_Two_QianNeng);
               }
               break;
            case 2:
               if(_loc5_ > CONST_COMMON.Ninja_Max_QianNeng)
               {
                  _loc5_ = uint(CONST_COMMON.Ninja_Max_QianNeng);
               }
         }
         TextField(this.FMC_Inherit["TF_Name_20"]).text = "+" + param2.GetQianNengOnlyLevelStr(param2.PotentialLevelShow);
         this.FNewPotentiaLv = param2.GetQianNengOnlyLevelStr(_loc5_);
         TextField(this.FMC_Inherit["TF_Name21"]).text = "+" + this.FNewPotentiaLv;
      }
      
      protected function getLevelNum() : void
      {
         this.MaxLevelForQianNengdatA = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_NinJaPractice,this.MaxLevelForQianNeng + 1) as TNinJaPractice;
         this.tempQianNengdatA = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_NinJaPractice,this.MaxLevelForQianNeng + 2) as TNinJaPractice;
         if(!this.MaxLevelForQianNengdatA)
         {
            return;
         }
         if(this.MaxLevelForQianNengdatA.NeedLv > SLogicsCore.Character.GetMainHero().Level || this.tempQianNengdatA.NeedTransLv > SLogicsCore.Character.GetMainHero().ReincarnationOneOrTwo)
         {
            return;
         }
         ++this.MaxLevelForQianNeng;
         this.MaxLevelForQianNengdatA = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_NinJaPractice,this.MaxLevelForQianNeng + 1) as TNinJaPractice;
         if(!this.MaxLevelForQianNengdatA)
         {
            return;
         }
         this.getLevelNum();
      }
      
      protected function get_hero_exp(param1:uint) : uint
      {
         var _loc2_:TNinJaPractice = null;
         _loc2_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_NinJaPractice,param1) as TNinJaPractice;
         return uint(_loc2_.TotalCost);
      }
      
      protected function get_hero_exp_next(param1:Number) : int
      {
         var _loc2_:TNinJaPractice = null;
         _loc2_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_NinJaPractice,param1) as TNinJaPractice;
         if(!_loc2_)
         {
            return 0;
         }
         return int(_loc2_.Cost);
      }
      
      protected function initValue_right() : void
      {
         var _loc4_:THero = null;
         this.heros = SLogicsCore.Character.Heros;
         var _loc1_:Number = Number(this.heros.Count);
         var _loc2_:JinJaPracticeUint = null;
         var _loc3_:int = 0;
         _loc3_ = 0;
         while(_loc3_ < _loc1_)
         {
            _loc4_ = this.heros.GetHeroByIndex(_loc3_);
            if(_loc4_.Identifier == this.id_arr[0])
            {
               if(this.vec_Uint02.length >= 1)
               {
                  _loc2_ = this.vec_Uint02[0];
               }
               else
               {
                  _loc2_ = new JinJaPracticeUint();
               }
               _loc2_.initin(MovieClip(this.FMC_Inherit["MC_HeadFirst"]),_loc4_,1);
               _loc2_.fction = this.selec_click;
               _loc2_.SetTabooBtn();
               this.vec_Uint02[0] = _loc2_;
               this.handlerHero_one(_loc4_);
               this.three_();
            }
            else if(_loc4_.Identifier == this.id_arr[1])
            {
               if(this.vec_Uint02.length >= 2)
               {
                  _loc2_ = this.vec_Uint02[1];
               }
               else
               {
                  _loc2_ = new JinJaPracticeUint();
               }
               _loc2_.initin(MovieClip(this.FMC_Inherit["MC_HeadSecond"]),_loc4_,1);
               _loc2_.fction = this.selec_click;
               _loc2_.SetTabooBtn();
               this.vec_Uint02[1] = _loc2_;
               if(this.id_arr[0] != 0 && this.vec_Uint02[0].hero != null)
               {
                  this.handlerHero_two(this.vec_Uint02[0].hero,this.vec_Uint02[1].hero);
               }
            }
            if(this.id_arr[0] == 0)
            {
               if(this.vec_Uint02.length >= 1)
               {
                  _loc2_ = this.vec_Uint02[0];
                  _loc2_.initin(null,_loc4_,1);
               }
            }
            if(this.id_arr[1] == 0)
            {
               if(this.vec_Uint02.length >= 2)
               {
                  _loc2_ = this.vec_Uint02[1];
                  _loc2_.initin(null,_loc4_,1);
               }
            }
            _loc3_++;
         }
      }
      
      protected function repre() : void
      {
         var _loc1_:Number = Number(this.heros.Count);
         var _loc2_:Number = 0;
         if(this.id_arr[0] != 0)
         {
            _loc1_--;
         }
         if(this.id_arr[1] != 0)
         {
            _loc1_--;
         }
         this.all_page_index = Math.ceil(_loc1_ / JINJA_MVC_COUNT);
         if(this.all_page_index < this.cur_page_index)
         {
            this.all_page_index += 1;
         }
         _loc2_ = this.cur_page_index;
         if(this.cur_page_index == 0)
         {
            _loc2_ = 0;
         }
         TextField(this.FMC_Inherit["TF_Page"]).text = _loc2_ + "/" + this.all_page_index;
         TGameUtil.setButtonMode(MovieClip(this.FMC_Inherit["MC_PageLeft"]),this.cur_page_index == 1 ? false : true);
         TGameUtil.setButtonMode(MovieClip(this.FMC_Inherit["MC_PageRight"]),this.cur_page_index >= this.all_page_index ? false : true);
      }
      
      override protected function LogicsPerform() : void
      {
         super.LogicsPerform();
         var _loc1_:int = int(this.vec_Uint01.length);
         var _loc2_:int = 0;
         if(_loc1_ != 0)
         {
            _loc2_ = 0;
            while(_loc2_ < _loc1_)
            {
               this.vec_Uint01[_loc2_].Update();
               _loc2_++;
            }
         }
         _loc1_ = int(this.vec_Uint02.length);
         _loc2_ = 0;
         if(_loc1_ != 0)
         {
            _loc2_ = 0;
            while(_loc2_ < _loc1_)
            {
               if(this.vec_Uint02[_loc2_]._id != 0)
               {
                  this.vec_Uint02[_loc2_].Update();
               }
               _loc2_++;
            }
         }
      }
      
      protected function addEvent() : void
      {
         SimpleButton(this.FMC_Inherit[CONST_NINJAPRACTICE.JP_CLOSE]).addEventListener(MouseEvent.CLICK,this.cloHandle);
         SimpleButton(this.FMC_Inherit["BTN_NijiaStarExchange"]).addEventListener(MouseEvent.CLICK,this.C_S);
         MovieClip(this.FMC_Inherit["MC_PageLeft"]).addEventListener(MouseEvent.CLICK,this.click_);
         MovieClip(this.FMC_Inherit["MC_PageRight"]).addEventListener(MouseEvent.CLICK,this.click_);
         MovieClip(this.FMC_Inherit["Activity_0"]["task"]).gotoAndStop(1);
         MovieClip(this.FMC_Inherit["Activity_1"]["task"]).gotoAndStop(2);
         MovieClip(this.FMC_Inherit["Activity_2"]["task"]).gotoAndStop(2);
         MovieClip(this.FMC_Inherit["Activity_3"]["task"]).gotoAndStop(2);
         MovieClip(this.FMC_Inherit["Activity_0"]["task"]).addEventListener(MouseEvent.CLICK,this.choseClick);
         MovieClip(this.FMC_Inherit["Activity_1"]["task"]).addEventListener(MouseEvent.CLICK,this.choseClick);
         MovieClip(this.FMC_Inherit["Activity_2"]["task"]).addEventListener(MouseEvent.CLICK,this.choseClick);
         MovieClip(this.FMC_Inherit["Activity_3"]["task"]).addEventListener(MouseEvent.CLICK,this.choseClick);
         this.three_();
      }
      
      protected function three_() : void
      {
         TextField(this.FMC_Inherit["Activity_0"]["CostValue"]).text = Number(this.mony_unit[0][0]) * 100 + "%";
         TextField(this.FMC_Inherit["Activity_1"]["CostValue"]).text = Number(this.mony_unit[1][0]) * 100 + "%";
         TextField(this.FMC_Inherit["Activity_2"]["CostValue"]).text = Number(this.mony_unit[2][0]) * 100 + "%";
         TextField(this.FMC_Inherit["Activity_3"]["CostValue"]).text = Number(this.mony_unit[3][0]) * 100 + "%";
         TextField(this.FMC_Inherit["Activity_0"]["CostValue1"]).text = this.getMonyCount(0);
         TextField(this.FMC_Inherit["Activity_1"]["CostValue1"]).text = this.getMonyCount(1);
         TextField(this.FMC_Inherit["Activity_2"]["CostValue1"]).text = this.getMonyCount(2);
         TextField(this.FMC_Inherit["Activity_3"]["CostValue1"]).text = this.getMonyCount(3);
         TextField(this.FMC_Inherit["Activity_0"]["CostName"]).text = this.get_price(int(this.mony_unit[0][1]));
         TextField(this.FMC_Inherit["Activity_1"]["CostName"]).text = this.get_price(int(this.mony_unit[1][1]));
         TextField(this.FMC_Inherit["Activity_2"]["CostName"]).text = this.get_price(int(this.mony_unit[2][1]));
         TextField(this.FMC_Inherit["Activity_3"]["CostName"]).text = this.get_price(int(this.mony_unit[3][1]));
         this.show(Number(this.mony_unit[this.inherit_type - 1][0]) * 100);
         this._cur_rate = this.mony_unit[this.inherit_type - 1][0];
      }
      
      protected function getMonyCount(param1:int) : String
      {
         var _loc2_:Number = 7;
         switch(param1)
         {
            case 0:
               _loc2_ = this.set_pracent_(0);
               break;
            case 1:
               _loc2_ = this.set_pracent_(1);
               break;
            case 2:
               _loc2_ = this.set_pracent_(2);
               break;
            case 3:
               _loc2_ = this.set_pracent_(3);
         }
         return String(_loc2_);
      }
      
      protected function set_pracent_(param1:int) : Number
      {
         var _loc3_:TNinJaPractice = null;
         if(this.id_arr[0] == 0)
         {
            return 0;
         }
         var _loc2_:THero = this.vec_Uint02[0].hero;
         if(_loc2_ == null)
         {
            return 0;
         }
         _loc3_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_NinJaPractice,_loc2_.PotentialLv + 1) as TNinJaPractice;
         var _loc4_:Number = _loc3_.TotalCost + _loc2_.PotentialExp;
         return Math.ceil(_loc4_ * Number(this.mony_unit[param1][0]) / Number(this.mony_unit[param1][2])) * Number(this.mony_unit[param1][3]);
      }
      
      protected function get_price(param1:int) : String
      {
         var _loc2_:String = STRING_INHERITPRACTICE.INHERIT_SILVER_COIN;
         switch(param1)
         {
            case 0:
               _loc2_ = STRING_INHERITPRACTICE.INHERIT_SILVER_COIN;
               break;
            case 1:
               _loc2_ = STRING_INHERITPRACTICE.INHERIT_GOLD;
               break;
            case 2:
               _loc2_ = STRING_INHERITPRACTICE.INHERIT_GIFT;
               break;
            case 3:
               _loc2_ = STRING_INHERITPRACTICE.INHERIT_GOLD;
         }
         return _loc2_;
      }
      
      protected function clear_one_two() : void
      {
         TextField(this.FMC_Inherit["MC_HeadFirst"]["xiulevel"]).text = "";
         TextField(this.FMC_Inherit["MC_HeadFirst"]["TF_Level"]).text = "";
         TextField(this.FMC_Inherit["MC_HeadFirst"]["TF_Name"]).text = "";
         TextField(this.FMC_Inherit["MC_HeadSecond"]["xiulevel"]).text = "";
         TextField(this.FMC_Inherit["MC_HeadSecond"]["TF_Level"]).text = "";
         TextField(this.FMC_Inherit["MC_HeadSecond"]["TF_Name"]).text = "";
      }
      
      protected function show(param1:Number) : void
      {
         TextField(this.FMC_Inherit["percent"]).text = String(param1) + "%";
      }
      
      public function choseClick(param1:MouseEvent) : void
      {
         switch(param1.currentTarget)
         {
            case this.FMC_Inherit["Activity_0"]["task"]:
               this.set_select_state(0);
               break;
            case this.FMC_Inherit["Activity_1"]["task"]:
               this.set_select_state(1);
               break;
            case this.FMC_Inherit["Activity_2"]["task"]:
               this.set_select_state(2);
               break;
            case this.FMC_Inherit["Activity_3"]["task"]:
               this.set_select_state(3);
         }
      }
      
      protected function set_select_state(param1:int) : void
      {
         MovieClip(this.FMC_Inherit["Activity_0"]["task"]).gotoAndStop(2);
         MovieClip(this.FMC_Inherit["Activity_1"]["task"]).gotoAndStop(2);
         MovieClip(this.FMC_Inherit["Activity_2"]["task"]).gotoAndStop(2);
         MovieClip(this.FMC_Inherit["Activity_3"]["task"]).gotoAndStop(2);
         MovieClip(this.FMC_Inherit["Activity_" + param1]["task"]).gotoAndStop(1);
         this.show(Number(this.mony_unit[param1][0]) * 100);
         this._cur_rate = this.mony_unit[param1][0];
         this.inherit_type = param1 + 1;
         if(this.id_arr[0] != 0 && this.id_arr[1] != 0)
         {
            this.handlerHero_two(this.vec_Uint02[0].hero,this.vec_Uint02[1].hero);
         }
      }
      
      public function cloHandle(param1:MouseEvent) : void
      {
         ProcessorClose();
         if(this.Fonose != null)
         {
            this.Fonose();
         }
      }
      
      public function set onose(param1:Function) : void
      {
         this.Fonose = param1;
      }
      
      public function get UpdateHeroPower() : Function
      {
         return this.FUpdateHeroPower;
      }
      
      public function set UpdateHeroPower(param1:Function) : void
      {
         this.FUpdateHeroPower = param1;
      }
      
      protected function ConfirmOnOk(param1:Object = null) : void
      {
         if(this.id_arr[0] != 0 && this.id_arr[1] != 0)
         {
            this.GetReward(this.inherit_type,this.id_arr[0],this.id_arr[1]);
         }
      }
      
      public function C_S(param1:MouseEvent) : void
      {
         var _loc2_:String = null;
         if(this.vec_Uint02[1].hero)
         {
            if(this.inherit_type > 1)
            {
               _loc2_ = TUtilityString.Format(new ConsumeFrame(CONST_SYSTEMLANGUAGE.ConsumerConfirm_NinJaPractice_Inheritance).DescribeString,this.getMonyCount(this.inherit_type - 1),this.vec_Uint02[1].hero.Name,this.FNewPotentiaLv);
               this.FPopWindow.Text = _loc2_.split("%n").join("\n");
               this.FPopWindow.visible = true;
            }
            else
            {
               this.tempFunc();
            }
         }
      }
      
      public function PopWindowOnOk(param1:Object) : void
      {
         this.tempFunc();
      }
      
      public function tempFunc() : void
      {
         if(this._bLostExp)
         {
            if(!this.FUIWindowConfirmation.IsSelected)
            {
               this.FUIWindowConfirmation.Text = STRING_INHERITPRACTICE.INHERIT_FORMATION;
               this.FUIWindowConfirmation.SetCheckBox(true);
               this.FUIWindowConfirmation.Visible = true;
            }
            else
            {
               this.ConfirmOnOk();
            }
         }
         else
         {
            this.ConfirmOnOk();
         }
      }
      
      public function selec_click(param1:uint, param2:int, param3:THero) : void
      {
         var _loc4_:int = 0;
         if(param2 == 0)
         {
            if(this.id_arr[0] == 0)
            {
               if(param3.PotentialLv != 0)
               {
                  this.id_arr[0] = param1;
                  _loc4_ = 1;
                  this.handlerHero_one(param3);
               }
               else
               {
                  EffectGenerateText(STRING_INHERITPRACTICE.INHERIT_ZEAR_MES);
               }
            }
            else if(this.id_arr[1] == 0 && this.id_arr[0] != 0)
            {
               this.id_arr[1] = param1;
               _loc4_ = 1;
            }
         }
         else
         {
            if(this.id_arr[0] == param1)
            {
               this.id_arr[0] = 0;
               _loc4_ = 1;
               this.clear_inherit();
            }
            if(this.id_arr[1] == param1)
            {
               this.id_arr[1] = 0;
               _loc4_ = 1;
               this.clear_inherit_M();
            }
         }
         if(_loc4_)
         {
            this.initValue();
         }
      }
      
      public function clear_inherit() : void
      {
         TextField(this.FMC_Inherit["TF_Name_10"]).text = "+0";
         TextField(this.FMC_Inherit["TF_Name_11"]).text = "+0";
         TextField(this.FMC_Inherit["Activity_0"]["CostValue1"]).text = "0";
         TextField(this.FMC_Inherit["Activity_1"]["CostValue1"]).text = "0";
         TextField(this.FMC_Inherit["Activity_2"]["CostValue1"]).text = "0";
         TextField(this.FMC_Inherit["Activity_3"]["CostValue1"]).text = "0";
      }
      
      public function clear_inherit_M() : void
      {
         TextField(this.FMC_Inherit["TF_Name_20"]).text = "+0";
         TextField(this.FMC_Inherit["TF_Name21"]).text = "+0";
      }
      
      public function click_(param1:MouseEvent) : void
      {
         switch(param1.currentTarget)
         {
            case this.FMC_Inherit["MC_PageLeft"]:
               if(this.cur_page_index > 1)
               {
                  this._open_close = false;
                  --this.cur_page_index;
                  this.initValue();
               }
               break;
            case this.FMC_Inherit["MC_PageRight"]:
               if(this.cur_page_index < this.all_page_index)
               {
                  this._open_close = true;
                  this.cur_page_index += 1;
                  this.initValue();
               }
         }
      }
      
      public function PerformPacket_SC_JinJaPractice_GetRewardOk(param1:TPacket) : void
      {
         var _loc2_:ByteArray = null;
         var _loc3_:uint = 0;
         var _loc4_:uint = 0;
         var _loc5_:uint = 0;
         var _loc6_:uint = 0;
         var _loc7_:uint = 0;
         var _loc8_:uint = 0;
         var _loc9_:uint = 0;
         var _loc10_:uint = 0;
         var _loc13_:THero = null;
         _loc2_ = param1.Data;
         _loc3_ = _loc2_.readUnsignedInt();
         if(_loc3_ != 0)
         {
            EffectGenerateTextByErrorCode(_loc3_);
            return;
         }
         MovieClip(this.FMC_Inherit["underpan"]).gotoAndPlay(2);
         _loc4_ = _loc2_.readUnsignedInt();
         _loc5_ = _loc2_.readUnsignedInt();
         _loc6_ = _loc2_.readUnsignedInt();
         _loc7_ = _loc2_.readUnsignedInt();
         _loc8_ = _loc2_.readUnsignedInt();
         _loc9_ = _loc2_.readUnsignedInt();
         _loc10_ = _loc2_.readUnsignedInt();
         this.heros = SLogicsCore.Character.Heros;
         var _loc11_:Number = Number(this.heros.Count);
         var _loc12_:int = 0;
         while(_loc12_ < _loc11_)
         {
            _loc13_ = this.heros.GetHeroByIndex(_loc12_);
            if(_loc13_.Identifier == this.id_arr[0])
            {
               _loc13_.PotentialLv = _loc7_;
               _loc13_.PotentialExp = _loc8_;
            }
            else if(_loc13_.Identifier == this.id_arr[1])
            {
               _loc13_.PotentialLv = _loc9_;
               _loc13_.PotentialExp = _loc10_;
            }
            _loc12_++;
         }
         this.id_arr[0] = 0;
         this.id_arr[1] = 0;
         this.clear_inherit();
         this.clear_inherit_M();
         this.initValue();
         if(this.FUpdateHeroPower != null)
         {
            this.FUpdateHeroPower(this,_loc4_);
            this.FUpdateHeroPower(this,_loc5_);
         }
      }
      
      protected function GetReward(param1:uint, param2:uint, param3:uint) : void
      {
         var _loc4_:TPacket = null;
         var _loc5_:ByteArray = null;
         _loc4_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_NinJaPractice_Inherit_Rep);
         _loc5_ = _loc4_.Data;
         _loc5_.writeInt(param2);
         _loc5_.writeInt(param3);
         _loc5_.writeInt(param1);
         SNetworkCore.Transceiver.PacketTransmit(_loc4_);
      }
   }
}

