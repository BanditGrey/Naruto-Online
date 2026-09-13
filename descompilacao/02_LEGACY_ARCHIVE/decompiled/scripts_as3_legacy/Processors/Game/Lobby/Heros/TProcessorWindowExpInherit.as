package Processors.Game.Lobby.Heros
{
   import Components.Pages.TUIPage;
   import Foundation.Common.Integer.UInt64;
   import Foundation.Resources.SResourcesCore;
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TUtilityReflection;
   import Foundation.Utilities.TUtilityString;
   import Logics.Characters.THero;
   import Logics.Characters.THeros;
   import Logics.DatebaseVO.VO.TConfigValue;
   import Logics.DatebaseVO.VO.THeroExp;
   import Logics.Inventories.TInventory;
   import Logics.SLogicsCore;
   import Processors.Game.Lobby.Common.TProcessorLobbyWindow;
   import Processors.Game.Lobby.NinJaPractice.JinJaPracticeUint;
   import Processors.Game.Lobby.TreasureMap.ConsumeFrame;
   import Processors.Game.Windows.Information.TUIWindowConfirmation;
   import Resources.Constants.CONST_COMMON;
   import Resources.Constants.CONST_CONFIGVALUE;
   import Resources.Constants.CONST_DATEBASEVO;
   import Resources.Constants.CONST_HEROS;
   import Resources.Constants.CONST_SYSTEMLANGUAGE;
   import Resources.Strings.STRING_HEROS;
   import Resources.Strings.STRING_INHERITPRACTICE;
   import Resources.Strings.STRING_WORLDMAP;
   import Utilities.UI.Windows.TUtilityUIWindow;
   import flash.display.MovieClip;
   import flash.display.SimpleButton;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   
   public class TProcessorWindowExpInherit extends TProcessorLobbyWindow
   {
      
      public static const JINJA_MVC_COUNT:int = 6;
      
      protected var FMC_ExpInherit:Sprite;
      
      protected var FUIPage:TUIPage;
      
      protected const CAPACITY_HeroHead:uint = 6;
      
      protected var FPageIndex:int;
      
      protected var FHeros:THeros;
      
      protected var FBTN_Close:SimpleButton;
      
      protected var FBTN_Inherit:SimpleButton;
      
      protected var vec_Uint01:Vector.<JinJaPracticeUint>;
      
      protected var vec_Uint02:Vector.<JinJaPracticeUint>;
      
      protected var mony_unit:Vector.<Object>;
      
      protected var inherit_type:uint = 1;
      
      protected var _cur_rate:Number = 0;
      
      protected var _open_close:Boolean = false;
      
      protected var id_arr:Array;
      
      protected var FCharacterMaxLevel:int;
      
      protected var FUIWindowConfirmation:TUIWindowConfirmation;
      
      protected var FExchangeOnClick:Function;
      
      protected var FCur_Index:int;
      
      protected var s0:UInt64;
      
      protected var s1:UInt64;
      
      protected var s2:UInt64;
      
      public function TProcessorWindowExpInherit(param1:TUIComponent)
      {
         super(param1);
         var _loc2_:JinJaPracticeUint = new JinJaPracticeUint();
         _loc2_.initin(null,null,0);
         var _loc3_:JinJaPracticeUint = new JinJaPracticeUint();
         _loc3_.initin(null,null,0);
         this.FUIPage = new TUIPage(this);
         this.vec_Uint01 = new Vector.<JinJaPracticeUint>();
         this.vec_Uint02 = new Vector.<JinJaPracticeUint>(2);
         this.vec_Uint02[0] = _loc2_;
         this.vec_Uint02[1] = _loc3_;
         this.id_arr = new Array(2);
         this.id_arr[0] = 0;
         this.id_arr[1] = 0;
         this.FUIWindowConfirmation = new TUIWindowConfirmation(this.Parent);
         this.FUIWindowConfirmation.OnOK = this.WindowConfirmationOnOK;
         this.FUIWindowConfirmation.x = (CONST_COMMON.STAGE_Width - this.FUIWindowConfirmation.WindowWidth) / 2;
         this.FUIWindowConfirmation.y = (CONST_COMMON.STAGE_Height - this.FUIWindowConfirmation.WindowHeight) / 2;
         this.FHeros = SLogicsCore.Character.Heros;
         this.s0 = new UInt64();
         this.s1 = new UInt64();
         this.s2 = new UInt64();
      }
      
      override protected function ResourcesPerform_UIRequest() : void
      {
         SResourcesCore.TexturesSwfLobby.LoadPrimary(CONST_HEROS.RESOURCESID_Swf_Heros);
         super.ResourcesPerform_UIRequest();
      }
      
      override protected function ResourcesPerform_UIDispatch() : void
      {
         var _loc1_:MovieClip = null;
         var _loc2_:TextField = null;
         this.graphics.beginFill(0,0.3);
         this.graphics.drawRect(-282,-120,CONST_COMMON.STAGE_Width,CONST_COMMON.STAGE_Height);
         this.graphics.endFill();
         this.FMC_ExpInherit = TUtilityReflection.CreateDisplayObjectInstance(CONST_HEROS.RESOURCE_ClassName_MC_ExpInherit) as Sprite;
         addChild(this.FMC_ExpInherit);
         this.FBTN_Close = this.FMC_ExpInherit[CONST_HEROS.RESOURCE_Link_Btn_Close];
         this.FBTN_Inherit = this.FMC_ExpInherit["Btn_Inherit"];
         MovieClip(this.FMC_ExpInherit["MC_HeadFirst"]["MC_Taboo_Btn"]).visible = false;
         MovieClip(this.FMC_ExpInherit["MC_HeadSecond"]["MC_Taboo_Btn"]).visible = false;
         _loc1_ = this.FMC_ExpInherit[CONST_HEROS.RESOURCE_Link_MC_PageLeft];
         this.FUIPage.ButtonPrevious.Substrate = _loc1_;
         _loc1_ = this.FMC_ExpInherit[CONST_HEROS.RESOURCE_Link_MC_PageRight];
         this.FUIPage.ButtonNext.Substrate = _loc1_;
         _loc2_ = this.FMC_ExpInherit[CONST_HEROS.RESOURCE_Link_TF_Page];
         this.FUIPage.LabelPage = _loc2_;
         _loc2_.text = "0/0";
         this.FUIPage.PageSize = this.CAPACITY_HeroHead;
         this.FUIPage.Init();
         this.FUIPage.OnChangePage = this.PageOnChange;
         TUtilityUIWindow.SetupWindowConfirmation(this.FUIWindowConfirmation);
         this.FUIWindowConfirmation.SetCheckBox(false);
         super.ResourcesPerform_UIDispatch();
      }
      
      override protected function ResourcesPerform_UILocations() : void
      {
         var _loc1_:TConfigValue = null;
         _loc1_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_ConfigValue,CONST_CONFIGVALUE.NinjaUpgrade_ExpInherit) as TConfigValue;
         this.mony_unit = _loc1_.Value as Vector.<Object>;
         _loc1_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_ConfigValue,CONST_CONFIGVALUE.VERSION_PALYER_LEVEL) as TConfigValue;
         this.FCharacterMaxLevel = _loc1_.Value as uint;
         SLogicsCore.Character.CurVersionMastLevel = this.FCharacterMaxLevel;
         this.FBTN_Close.addEventListener(MouseEvent.CLICK,this.BTNCloseOnClick,false,0,true);
         this.FBTN_Inherit.addEventListener(MouseEvent.CLICK,this.InheritOnClick,false,0,true);
         MovieClip(this.FMC_ExpInherit["MC_Explain0"]["task"]).gotoAndStop(2);
         MovieClip(this.FMC_ExpInherit["MC_Explain1"]["task"]).gotoAndStop(1);
         MovieClip(this.FMC_ExpInherit["MC_Explain0"]["task"]).addEventListener(MouseEvent.CLICK,this.choseClick);
         MovieClip(this.FMC_ExpInherit["MC_Explain1"]["task"]).addEventListener(MouseEvent.CLICK,this.choseClick);
         this.three_();
         this.clear_inherit();
         this.clear_inherit_M();
         super.ResourcesPerform_UILocations();
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
      
      protected function three_() : void
      {
         var _loc1_:String = Number(this.mony_unit[0][0]) * 100 + "%";
         TextField(this.FMC_ExpInherit["MC_Explain0"]["CostValue"]).text = STRING_HEROS.STRING_InheritExp.split("0%").join(_loc1_);
         _loc1_ = Number(this.mony_unit[1][0]) * 100 + "%";
         TextField(this.FMC_ExpInherit["MC_Explain1"]["CostValue"]).text = STRING_HEROS.STRING_InheritExp.split("0%").join(_loc1_);
         this.four_();
         TextField(this.FMC_ExpInherit["MC_Explain0"]["CostName"]).text = this.get_price(int(this.mony_unit[0][1]));
         TextField(this.FMC_ExpInherit["MC_Explain1"]["CostName"]).text = this.get_price(int(this.mony_unit[1][1]));
         this._cur_rate = this.mony_unit[this.inherit_type - 1][0];
      }
      
      protected function four_() : void
      {
         TextField(this.FMC_ExpInherit["MC_Explain0"]["CostValue1"]).text = this.getMonyCount(0);
         TextField(this.FMC_ExpInherit["MC_Explain1"]["CostValue1"]).text = this.getMonyCount(1);
      }
      
      protected function PageOnChange(param1:Object, param2:int) : void
      {
         if(param2 > this.FPageIndex)
         {
            this._open_close = true;
         }
         else
         {
            this._open_close = false;
         }
         this.FPageIndex = param2;
         this.initValue();
      }
      
      protected function UpdatePageInfo() : void
      {
         var _loc1_:int = 0;
         if(this.id_arr[0] != 0)
         {
            _loc1_++;
         }
         if(this.id_arr[1] != 0)
         {
            _loc1_++;
         }
         this.FUIPage.TotalQuantity = this.FHeros.Count - _loc1_;
         this.FUIPage.UpdateCopy();
         if(this.FPageIndex >= this.FUIPage.TotalPage)
         {
            this.FPageIndex = this.FUIPage.TotalPage - 1;
            if(this.FPageIndex <= 0)
            {
               this.FPageIndex = 0;
            }
         }
         this.FUIPage.PageIndex = this.FPageIndex;
         this.FUIPage.Update();
      }
      
      protected function initValue() : void
      {
         var _loc2_:JinJaPracticeUint = null;
         var _loc9_:THero = null;
         var _loc10_:int = 0;
         var _loc11_:THero = null;
         this.clear_one_two();
         var _loc1_:int = this.FHeros.Count;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:int = 100;
         var _loc7_:int = 100;
         var _loc8_:int = 0;
         _loc4_ = 0;
         while(_loc4_ < _loc1_)
         {
            _loc9_ = this.FHeros.GetHeroByIndex(_loc4_);
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
            _loc10_ = _loc4_ + this.FPageIndex * JINJA_MVC_COUNT;
            if(this._open_close)
            {
               _loc8_ = 0;
               if(_loc6_ < _loc7_)
               {
                  if(_loc10_ + _loc8_ >= _loc6_ && _loc6_ != 100)
                  {
                     _loc8_ += 1;
                  }
                  if(_loc10_ + _loc8_ >= _loc7_ && _loc7_ != 100)
                  {
                     _loc8_ += 1;
                  }
               }
               else
               {
                  if(_loc10_ + _loc8_ >= _loc7_ && _loc7_ != 100)
                  {
                     _loc8_ += 1;
                  }
                  if(_loc10_ + _loc8_ >= _loc6_ && _loc6_ != 100)
                  {
                     _loc8_ += 1;
                  }
               }
               _loc10_ += _loc8_;
            }
            if(_loc10_ >= _loc1_)
            {
               if(_loc3_ <= 5)
               {
                  MovieClip(this.FMC_ExpInherit["MC_Hero_" + _loc3_]).visible = false;
                  _loc3_++;
               }
            }
            else
            {
               _loc11_ = this.FHeros.GetHeroByIndex(_loc10_);
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
                  _loc2_.initin(MovieClip(this.FMC_ExpInherit["MC_Hero_" + _loc3_]),_loc11_,0);
                  _loc2_.fction = this.selec_click;
                  this.vec_Uint01[_loc3_] = _loc2_;
                  MovieClip(this.FMC_ExpInherit["MC_Hero_" + _loc3_]).visible = true;
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
      }
      
      public function selec_click(param1:uint, param2:int, param3:THero) : void
      {
         var _loc5_:THero = null;
         var _loc6_:THero = null;
         var _loc7_:int = 0;
         var _loc8_:THero = null;
         var _loc4_:int = 0;
         if(param2 == 0)
         {
            if(param3.Identifier == SLogicsCore.Character.GetMainHero().Identifier)
            {
               EffectGenerateText(STRING_INHERITPRACTICE.INHERIT_FORTION08);
               return;
            }
            if(param3.ExpIsInherited)
            {
               EffectGenerateText(STRING_INHERITPRACTICE.INHERIT_FORTION05);
               return;
            }
            if(this.id_arr[0] == 0)
            {
               if(param3.Level == param3.InitilizationLevel && param3.Experience.ToNumber() <= 1 || this.get_hero_exp(param3) <= 0)
               {
                  EffectGenerateText(STRING_INHERITPRACTICE.INHERIT_FORTION09);
               }
               else
               {
                  this.id_arr[0] = param1;
                  _loc4_ = 1;
                  this.handlerHero_one(param3);
               }
            }
            else if(this.id_arr[1] == 0 && this.id_arr[0] != 0)
            {
               _loc5_ = null;
               _loc6_ = null;
               _loc7_ = 0;
               while(_loc7_ < this.FHeros.Count)
               {
                  _loc8_ = this.FHeros.GetHeroByIndex(_loc7_);
                  if(_loc8_.Identifier == this.id_arr[0])
                  {
                     _loc5_ = _loc8_;
                  }
                  else if(_loc8_.Identifier == param1)
                  {
                     _loc6_ = _loc8_;
                  }
                  _loc7_++;
               }
               if(_loc6_.Level > _loc5_.Level)
               {
                  EffectGenerateText(STRING_INHERITPRACTICE.INHERIT_FORTION10);
                  return;
               }
               this.id_arr[1] = param1;
               _loc4_ = 1;
            }
         }
         else
         {
            if(this.id_arr[0] == param1)
            {
               this.id_arr[0] = 0;
               this.id_arr[1] = 0;
               _loc4_ = 1;
               this.clear_inherit();
               this.clear_inherit_M();
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
            this.UpdatePageInfo();
            this.initValue();
         }
      }
      
      protected function handlerHero_one(param1:THero) : void
      {
         TextField(this.FMC_ExpInherit["TF_pre_Inherit0"]).text = SLogicsCore.Character.MainHero.GetLevelStrByLevel(param1.Level);
         TextField(this.FMC_ExpInherit["TF_pre_Inherit1"]).text = SLogicsCore.Character.MainHero.GetLevelStrByLevel(param1.Level);
      }
      
      protected function handlerHero_two(param1:THero, param2:THero) : void
      {
         if(this.id_arr[0] == 0)
         {
            if(this.id_arr[1] == 0)
            {
               TextField(this.FMC_ExpInherit["TF_pre_Inherit00"]).text = STRING_WORLDMAP.STRINGS_LV + "0";
               TextField(this.FMC_ExpInherit["TF_pre_Inherit01"]).text = STRING_WORLDMAP.STRINGS_LV + "0";
            }
            else
            {
               TextField(this.FMC_ExpInherit["TF_pre_Inherit00"]).text = SLogicsCore.Character.MainHero.GetLevelStrByLevel(param2.InitilizationLevel);
               TextField(this.FMC_ExpInherit["TF_pre_Inherit01"]).text = SLogicsCore.Character.MainHero.GetLevelStrByLevel(param2.Level);
            }
            return;
         }
         var _loc3_:Number = param1.Experience.ToNumber();
         var _loc4_:Number = param2.Experience.ToNumber();
         var _loc5_:Number = this.get_hero_exp_all(param1.Level);
         var _loc6_:Number = this.get_hero_exp_all(param1.InitilizationLevel);
         var _loc7_:Number = 0;
         _loc7_ = _loc5_ + _loc3_ + _loc4_ - _loc6_;
         var _loc8_:Number = 0;
         var _loc9_:Number = 0;
         _loc8_ = _loc7_ * this._cur_rate;
         var _loc10_:uint = param2.Level;
         while(true)
         {
            if(_loc10_ >= this.FCharacterMaxLevel)
            {
               _loc10_ = uint(this.FCharacterMaxLevel);
               break;
            }
            _loc9_ = this.get_hero_exp_next(_loc10_);
            if(_loc9_ > _loc8_)
            {
               break;
            }
            _loc10_ = uint(this.get_hero_exp_next_level(_loc10_));
            _loc8_ -= _loc9_;
         }
         switch(SLogicsCore.Character.GetMainHero().ReincarnationOneOrTwo)
         {
            case 0:
               if(_loc10_ > SLogicsCore.Character.GetMainHero().Level)
               {
                  _loc10_ = uint(SLogicsCore.Character.GetMainHero().Level);
               }
               break;
            case 1:
               if(param2.ReincarnationOneOrTwo == 0)
               {
                  if(_loc10_ > CONST_COMMON.Ninja_BeforeReincarnation_MaxLevel)
                  {
                     _loc10_ = uint(CONST_COMMON.Ninja_BeforeReincarnation_MaxLevel);
                  }
               }
               else if(_loc10_ > SLogicsCore.Character.GetMainHero().Level)
               {
                  _loc10_ = uint(SLogicsCore.Character.GetMainHero().Level);
               }
               break;
            case 2:
               switch(param2.ReincarnationOneOrTwo)
               {
                  case 0:
                     if(_loc10_ > CONST_COMMON.Ninja_BeforeReincarnation_MaxLevel)
                     {
                        _loc10_ = uint(CONST_COMMON.Ninja_BeforeReincarnation_MaxLevel);
                     }
                     break;
                  case 1:
                     if(_loc10_ > CONST_COMMON.Ninja_BeforeReincarnationOne_MaxLevel)
                     {
                        _loc10_ = uint(CONST_COMMON.Ninja_BeforeReincarnationOne_MaxLevel);
                     }
                     break;
                  case 2:
                     if(_loc10_ > SLogicsCore.Character.GetMainHero().Level)
                     {
                        _loc10_ = uint(SLogicsCore.Character.GetMainHero().Level);
                     }
               }
         }
         TextField(this.FMC_ExpInherit["TF_pre_Inherit00"]).text = SLogicsCore.Character.MainHero.GetLevelStrByLevel(param2.Level);
         TextField(this.FMC_ExpInherit["TF_pre_Inherit01"]).text = SLogicsCore.Character.MainHero.GetLevelStrByLevel(_loc10_);
      }
      
      protected function get_hero_exp(param1:THero) : Number
      {
         var _loc2_:Number = 0;
         var _loc3_:Number = this.get_hero_exp_all(param1.Level);
         var _loc4_:Number = param1.Experience.ToNumber();
         var _loc5_:Number = this.get_hero_exp_all(param1.InitilizationLevel);
         return _loc3_ + _loc4_ - _loc5_;
      }
      
      protected function get_hero_exp_next(param1:uint) : Number
      {
         var _loc2_:THeroExp = null;
         _loc2_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_HeroExp,param1) as THeroExp;
         return int(_loc2_.NeedExp.ToNumber());
      }
      
      protected function get_hero_exp_next_level(param1:int) : int
      {
         var _loc2_:THeroExp = null;
         _loc2_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_HeroExp,param1) as THeroExp;
         if(_loc2_.Nextlv == 0)
         {
            param1--;
            _loc2_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_HeroExp,param1) as THeroExp;
         }
         return _loc2_.Nextlv;
      }
      
      protected function get_hero_exp_all(param1:uint) : Number
      {
         var _loc2_:THeroExp = null;
         _loc2_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_HeroExp,param1) as THeroExp;
         _loc2_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_HeroExp,_loc2_.Frontlv) as THeroExp;
         if(!_loc2_)
         {
            return 0;
         }
         return _loc2_.AllExp.ToNumber();
      }
      
      protected function initValue_right() : void
      {
         var _loc2_:JinJaPracticeUint = null;
         var _loc4_:THero = null;
         var _loc1_:int = this.FHeros.Count;
         var _loc3_:int = 0;
         _loc3_ = 0;
         while(_loc3_ < _loc1_)
         {
            _loc4_ = this.FHeros.GetHeroByIndex(_loc3_);
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
               _loc2_.initin(MovieClip(this.FMC_ExpInherit["MC_HeadFirst"]),_loc4_,1);
               _loc2_.fction = this.selec_click;
               this.vec_Uint02[0] = _loc2_;
               this.handlerHero_one(_loc4_);
               this.four_();
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
               _loc2_.initin(MovieClip(this.FMC_ExpInherit["MC_HeadSecond"]),_loc4_,1);
               _loc2_.fction = this.selec_click;
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
      
      public function choseClick(param1:MouseEvent) : void
      {
         switch(param1.currentTarget)
         {
            case this.FMC_ExpInherit["MC_Explain0"]["task"]:
               this.set_select_state(0);
               break;
            case this.FMC_ExpInherit["MC_Explain1"]["task"]:
               this.set_select_state(1);
         }
      }
      
      protected function set_select_state(param1:int) : void
      {
         this.FCur_Index = param1;
         MovieClip(this.FMC_ExpInherit["MC_Explain0"]["task"]).gotoAndStop(1);
         MovieClip(this.FMC_ExpInherit["MC_Explain1"]["task"]).gotoAndStop(1);
         MovieClip(this.FMC_ExpInherit["MC_Explain" + param1]["task"]).gotoAndStop(2);
         this._cur_rate = this.mony_unit[param1][0];
         this.inherit_type = param1 + 1;
         if(this.id_arr[0] != 0 && this.id_arr[1] != 0)
         {
            this.handlerHero_two(this.vec_Uint02[0].hero,this.vec_Uint02[1].hero);
         }
      }
      
      protected function InheritOnClick(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         var _loc3_:THero = null;
         var _loc4_:String = null;
         if(this.id_arr[0] != 0 && this.id_arr[1] != 0)
         {
            _loc3_ = null;
            _loc2_ = 0;
            while(_loc2_ < this.FHeros.Count)
            {
               if(this.FHeros.GetHeroByIndex(_loc2_).Identifier == this.id_arr[0])
               {
                  _loc3_ = this.FHeros.GetHeroByIndex(_loc2_);
                  break;
               }
               _loc2_++;
            }
            if(!_loc3_)
            {
               return;
            }
            if(this.CheckEquipMentsMounted(_loc3_))
            {
               EffectGenerateText(STRING_HEROS.STRING_StripEquipment);
               return;
            }
            if(this.CheckTalismanMounted(_loc3_))
            {
               EffectGenerateText(STRING_HEROS.STRING_StripAdder);
               return;
            }
            if(this.CheckAccessoryMounted(_loc3_))
            {
               EffectGenerateText(STRING_HEROS.STRING_StripAdderAccessory);
               return;
            }
            _loc4_ = "";
            if(this.FCur_Index)
            {
               _loc4_ = this.get_price(4);
            }
            else
            {
               _loc4_ = this.get_price(0);
            }
            this.FUIWindowConfirmation.Visible = true;
            this.FUIWindowConfirmation.Text = TUtilityString.Format(new ConsumeFrame(CONST_SYSTEMLANGUAGE.ConsumerConfirm_Hero_ExpInheritance).DescribeString,this.getMonyCount(this.FCur_Index),_loc4_);
         }
      }
      
      protected function WindowConfirmationOnOK(param1:Object) : void
      {
         if(this.FExchangeOnClick != null)
         {
            this.FExchangeOnClick(this.id_arr[0],this.id_arr[1],this.inherit_type);
         }
      }
      
      protected function BTNCloseOnClick(param1:MouseEvent) : void
      {
         if(FOnClose != null)
         {
            FOnClose(this);
            this.ClearAlong();
         }
      }
      
      protected function ClearAlong() : void
      {
         this.id_arr[0] = 0;
         this.id_arr[1] = 0;
         this.set_select_state(0);
         this.clear_inherit();
         this.clear_inherit_M();
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
         if(this.id_arr[0] == 0)
         {
            return 0;
         }
         var _loc2_:THero = this.vec_Uint02[0].hero;
         if(_loc2_ == null)
         {
            return 0;
         }
         var _loc3_:Number = 0;
         var _loc4_:Number = this.get_hero_exp_all(_loc2_.Level);
         var _loc5_:Number = _loc2_.Experience.ToNumber();
         var _loc6_:Number = this.get_hero_exp_all(_loc2_.InitilizationLevel);
         _loc3_ = _loc4_ + _loc5_ - _loc6_;
         return Math.ceil(Number(_loc3_ / this.mony_unit[param1][2]) * Number(this.mony_unit[param1][0])) * Number(this.mony_unit[param1][3]);
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
            case 3:
               _loc2_ = STRING_INHERITPRACTICE.INHERIT_GOLD;
               break;
            case 2:
               _loc2_ = STRING_INHERITPRACTICE.INHERIT_GIFT;
               break;
            case 4:
               _loc2_ = STRING_INHERITPRACTICE.INHERIT_GOLDOrVouchers;
         }
         return _loc2_;
      }
      
      protected function clear_one_two() : void
      {
         TextField(this.FMC_ExpInherit["MC_HeadFirst"]["TF_Level"]).text = "";
         TextField(this.FMC_ExpInherit["MC_HeadFirst"]["TF_Name"]).text = "";
         TextField(this.FMC_ExpInherit["MC_HeadSecond"]["TF_Level"]).text = "";
         TextField(this.FMC_ExpInherit["MC_HeadSecond"]["TF_Name"]).text = "";
      }
      
      public function clear_inherit() : void
      {
         TextField(this.FMC_ExpInherit["TF_pre_Inherit0"]).text = STRING_WORLDMAP.STRINGS_LV + "0";
         TextField(this.FMC_ExpInherit["TF_pre_Inherit1"]).text = STRING_WORLDMAP.STRINGS_LV + "0";
         TextField(this.FMC_ExpInherit["MC_Explain0"]["CostValue1"]).text = "0";
         TextField(this.FMC_ExpInherit["MC_Explain1"]["CostValue1"]).text = "0";
      }
      
      public function clear_inherit_M() : void
      {
         TextField(this.FMC_ExpInherit["TF_pre_Inherit00"]).text = STRING_WORLDMAP.STRINGS_LV + "0";
         TextField(this.FMC_ExpInherit["TF_pre_Inherit01"]).text = STRING_WORLDMAP.STRINGS_LV + "0";
      }
      
      public function get ExchangeOnClick() : Function
      {
         return this.FExchangeOnClick;
      }
      
      public function set ExchangeOnClick(param1:Function) : void
      {
         this.FExchangeOnClick = param1;
      }
      
      public function openMe() : void
      {
         this.UpdatePageInfo();
         this.initValue();
      }
      
      public function S_C_Reflash() : void
      {
         this.id_arr[0] = 0;
         this.id_arr[1] = 0;
         this.UpdatePageInfo();
         this.initValue();
         this.clear_inherit();
         this.clear_inherit_M();
      }
      
      protected function CheckEquipMentsMounted(param1:THero) : Boolean
      {
         var _loc2_:uint = 0;
         var _loc3_:int = 0;
         var _loc4_:TInventory = null;
         _loc2_ = uint(param1.EquipmentsMounted.Capacity);
         _loc3_ = 0;
         while(_loc3_ < _loc2_)
         {
            _loc4_ = param1.EquipmentsMounted.GetInventoryByIndex(_loc3_);
            if(_loc4_ != null)
            {
               return true;
            }
            _loc3_++;
         }
         return false;
      }
      
      protected function CheckTalismanMounted(param1:THero) : Boolean
      {
         var _loc2_:uint = 0;
         var _loc3_:int = 0;
         var _loc4_:TInventory = null;
         _loc2_ = uint(param1.TalismansMounted.Capacity);
         _loc3_ = 0;
         while(_loc3_ < _loc2_)
         {
            _loc4_ = param1.TalismansMounted.GetInventoryByIndex(_loc3_);
            if(_loc4_ != null)
            {
               return true;
            }
            _loc3_++;
         }
         return false;
      }
      
      protected function CheckAccessoryMounted(param1:THero) : Boolean
      {
         var _loc2_:uint = 0;
         var _loc3_:int = 0;
         var _loc4_:TInventory = null;
         _loc2_ = uint(param1.AccessoryMounted.Capacity);
         _loc3_ = 0;
         while(_loc3_ < _loc2_)
         {
            _loc4_ = param1.AccessoryMounted.GetInventoryByIndex(_loc3_);
            if(_loc4_ != null)
            {
               return true;
            }
            _loc3_++;
         }
         return false;
      }
   }
}

