package Logics.Streamization.Post
{
   import Foundation.Streamization.*;
   import Foundation.Utilities.*;
   import Logics.*;
   import Logics.DatebaseVO.VO.*;
   import Logics.DatebaseVO.VO.Json.Post.*;
   import Logics.HyperStrings.*;
   import Logics.HyperStrings.Elements.*;
   import Resources.Constants.*;
   import flash.utils.*;
   import ghostcat.util.data.*;
   
   public class TUnstreamizerPost extends TUnstreamizer
   {
      
      protected static const CLASSNAMECOMBAT_VEC:Vector.<String> = CONST_POST.CLASSNAMECOMBAT_VEC;
      
      protected static const CLASSNAME_VEC:Vector.<Class> = CONST_POST.CLASSNAME_VEC;
      
      protected static const CLASSNAME_NOUNDERLINE_VEC:Vector.<Class> = CONST_POST.CLASSNAME_NOUNDERLINE_VEC;
      
      protected static const CLASSNAME_UNDERLINE_VEC:Vector.<Class> = CONST_POST.CLASSNAME_UNDERLINE_VEC;
      
      public function TUnstreamizerPost()
      {
         super();
      }
      
      override protected function UnstreamizationPerform(param1:ByteArray, param2:Object, param3:Object) : void
      {
         var _loc4_:int = 0;
         var _loc5_:uint = 0;
         var _loc6_:ByteArray = null;
         var _loc7_:TPost = null;
         var _loc8_:String = null;
         var _loc9_:String = null;
         var _loc10_:Object = null;
         var _loc11_:Object = null;
         var _loc12_:Array = null;
         var _loc13_:Class = null;
         var _loc14_:* = undefined;
         var _loc15_:THyperString = null;
         var _loc16_:Array = null;
         var _loc17_:THyperStringElementText = null;
         var _loc18_:THyperStringElementLinkCharacter = null;
         var _loc19_:THyperStringElementLinkItem = null;
         var _loc20_:THyperStringElementLinkHero = null;
         var _loc21_:THyperStringElementLinkEvent = null;
         var _loc22_:THyperStringElementLinkURL = null;
         var _loc23_:Array = null;
         var _loc24_:* = undefined;
         var _loc25_:int = 0;
         _loc6_ = param1;
         _loc15_ = param2 as THyperString;
         _loc7_ = param3 as TPost;
         _loc8_ = TUtilityString.FetchUTF(_loc6_);
         if(_loc8_ == "")
         {
            return;
         }
         _loc10_ = Json.decode(_loc8_);
         if(Boolean(_loc7_) && _loc7_.Event != "")
         {
            _loc11_ = Json.decode(_loc7_.Event);
         }
         if(_loc7_)
         {
            _loc8_ = _loc7_.TemplateTaskFront;
         }
         else
         {
            _loc23_ = _loc10_["OutLineUnderline"] as Array;
            if(_loc23_.length >= 2)
            {
               _loc8_ = _loc23_[2];
            }
         }
         _loc12_ = _loc8_.split("$");
         loop0:
         for(_loc24_ in _loc12_)
         {
            if(_loc12_[_loc24_] == "")
            {
               continue;
            }
            if(!this.CheckHasKey(_loc12_[_loc24_],_loc10_))
            {
               if(_loc11_ != null)
               {
                  if(this.CheckHasKey(_loc12_[_loc24_],_loc11_))
                  {
                     _loc16_ = _loc11_[_loc12_[_loc24_]] as Array;
                     _loc21_ = SLogicsCore.PoolHyperString.AcquireElementLinkEvent();
                     _loc21_.Text = _loc16_[0];
                     _loc21_.EventID = parseInt(_loc12_[_loc24_]);
                     _loc21_.Color = 4278190080;
                     if(_loc10_["Paramete"] != null)
                     {
                        _loc21_.Tag = _loc10_["Paramete"][0];
                     }
                     _loc15_.Add(_loc21_);
                  }
                  else
                  {
                     _loc17_ = SLogicsCore.PoolHyperString.AcquireElementText();
                     _loc17_.Text = _loc12_[_loc24_];
                     _loc17_.Color = _loc7_.TextColor;
                     _loc15_.Add(_loc17_);
                  }
               }
               else
               {
                  _loc17_ = SLogicsCore.PoolHyperString.AcquireElementText();
                  _loc17_.Text = _loc12_[_loc24_];
                  _loc17_.Color = _loc7_ ? _loc7_.TextColor : 13421670;
                  _loc15_.Add(_loc17_);
               }
               continue;
            }
            _loc9_ = _loc12_[_loc24_].split("_")[0];
            _loc25_ = 0;
            while(true)
            {
               if(_loc25_ < CLASSNAMECOMBAT_VEC.length)
               {
                  if(_loc9_ != CLASSNAMECOMBAT_VEC[_loc25_])
                  {
                     continue;
                  }
                  _loc13_ = CLASSNAME_VEC[_loc25_];
                  _loc14_ = new _loc13_(_loc10_[_loc12_[_loc24_]] as Array);
                  if(!_loc14_["Underline"])
                  {
                     break;
                  }
                  switch(_loc13_)
                  {
                     case THeroNameQualityUnderline:
                        this.SetElementLinkHeroInfo(_loc20_,_loc14_,_loc15_);
                        break;
                     case TPlayerQualityUnderline:
                     case TPlayerCountryUnderline:
                        this.SetElementLinkCharacterInfo(_loc18_,_loc14_,_loc15_);
                        break;
                     case TItemUnderline:
                        this.SetElementLinkItemInfo(_loc19_,_loc14_,_loc15_);
                        break;
                     case TLinkURL:
                        this.SetElementLinkURL(_loc22_,_loc14_,_loc15_);
                        break;
                     case TBBUnderline:
                        this.SetElementLinkBBInfo(_loc19_,_loc14_,_loc15_);
                        break;
                     default:
                        continue;
                  }
               }
               addr034b:
               continue loop0;
               _loc25_++;
            }
            _loc17_ = SLogicsCore.PoolHyperString.AcquireElementText();
            if(parseInt(_loc14_["Color"]) != 0)
            {
               _loc17_.Color = parseInt(_loc14_["Color"]);
            }
            else
            {
               _loc17_.Color = 4278190080;
            }
            if(_loc14_ is TReward)
            {
               _loc17_.Text = _loc14_["Name"] + "*" + _loc14_["Num"];
            }
            else
            {
               _loc17_.Text = _loc14_["Name"];
            }
            _loc15_.Add(_loc17_);
            §§goto(addr034b);
         }
      }
      
      protected function CheckHasKey(param1:String, param2:Object) : Boolean
      {
         var _loc3_:* = undefined;
         for(_loc3_ in param2)
         {
            if(param1 == _loc3_)
            {
               return true;
            }
         }
         return false;
      }
      
      protected function SetElementLinkHeroInfo(param1:THyperStringElementLinkHero, param2:*, param3:THyperString) : void
      {
         param1 = SLogicsCore.PoolHyperString.AcquireElementLinkHero();
         param1.Text = param2["Name"];
         param1.IDTemplate = parseInt(param2["IDTemplate"]);
         param1.Color = parseInt(param2["Color"]);
         param3.Add(param1);
      }
      
      protected function SetElementLinkCharacterInfo(param1:THyperStringElementLinkCharacter, param2:*, param3:THyperString) : void
      {
         param1 = SLogicsCore.PoolHyperString.AcquireElementLinkCharacter();
         param1.Text = param2["Name"];
         param1.Color = parseInt(param2["Color"]);
         param1.Identifier0 = parseInt(param2["Identifier0"]);
         param1.Identifier1 = parseInt(param2["Identifier1"]);
         param3.Add(param1);
      }
      
      protected function SetElementLinkItemInfo(param1:THyperStringElementLinkItem, param2:*, param3:THyperString) : void
      {
         param1 = SLogicsCore.PoolHyperString.AcquireElementLinkItem();
         param1.Text = param2["Name"];
         param1.Color = parseInt(param2["Color"]);
         param1.IDTemplate = parseInt(param2["IDTemplate"]);
         param3.Add(param1);
      }
      
      protected function SetElementLinkURL(param1:THyperStringElementLinkURL, param2:*, param3:THyperString) : void
      {
         param1 = SLogicsCore.PoolHyperString.AcquireElementLinkURL();
         param1.Text = param2["Name"];
         param1.HyperlinkAddress = param2["HyperlinkAddress"];
         param3.Add(param1);
      }
      
      protected function SetElementLinkBBInfo(param1:THyperStringElementLinkItem, param2:*, param3:THyperString) : void
      {
         param1 = SLogicsCore.PoolHyperString.AcquireElementLinkItem();
         param1.Text = param2["Name"];
         param1.Color = parseInt(param2["Color"]);
         param1.IDTemplate = parseInt(param2["IDTemplate"]);
         param3.Add(param1);
      }
      
      protected function UnstreamizationPerformOnlyPost(param1:ByteArray, param2:Object, param3:Object) : void
      {
         var _loc4_:THyperStringElementText = null;
         var _loc5_:String = null;
         var _loc6_:THyperString = null;
         _loc5_ = param3 as String;
         _loc6_ = param2 as THyperString;
         _loc4_ = SLogicsCore.PoolHyperString.AcquireElementText();
         _loc4_.Text = _loc5_;
         _loc4_.ColorOverride(13421670);
         _loc6_.Add(_loc4_);
      }
      
      override public function Unstreamize(param1:ByteArray, param2:Object, param3:Object) : void
      {
         this.UnstreamizationPerform(param1,param2,param3);
      }
      
      public function UnstreamizeOnlyOnMarQueen(param1:ByteArray, param2:Object, param3:Object) : void
      {
         this.UnstreamizationPerformOnlyPost(param1,param2,param3);
      }
   }
}

